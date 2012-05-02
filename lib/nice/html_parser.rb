require 'nokogiri'
require 'yaml'

module Nice
  class HtmlParser
  
    def self.remove_elements_not_of_state(state, doc)

      doc.css("[data-state]").each do |node|
        if node.attribute('data-state').value != state then
          node.remove
        end
      end
      doc.to_html
    end

  	def run url
  		doc = Nokogiri::HTML(open(url))
  		prev_state = "first"
  		curr_state = "second"		
		
		
  		# get all nodes of the previous state
  		prev_state_nodes = doc.css("[data-state='#{prev_state}']")
		
  		# generate removes for elements of previous state
  		js_stack = prev_state_nodes.map do |prev_node|
  			generate_js_remove prev_node
  		end

  		# get all nodes of the current state
  		curr_state_nodes = doc.css("[data-state='#{curr_state}']")

  		# get reference nodes in DOM tree for current nodes and generate js insert statements
  		js_stack += curr_state_nodes.map do |curr_node|
  			if curr_node.previous_element then
  				generate_js_insert_after curr_node, ref_node_uid(curr_node['data-uid'])
  			else
  				generate_js_insert_inside curr_node, ref_node_uid(curr_node['data-uid'])
  			end
  		end
		
  		puts js_stack
  	end
	
	
  	private
	
  	def ref_node_uid (node_uid)
  		"#{node_uid}_ref"
  	end

  	#generates js code to insert 'new_node' after 'reference_node'
  	#TODO: this is js library dependent and should be interfaced	
  	def generate_js_insert_after new_node, reference_node_ref
  		return "$([data-uid='#{reference_node_ref}']).insert('#{new_node.to_html}');"
  	end

  	#generates js code to insert 'new_node' inside 'reference_node'
  	#TODO: this is js library dependent and should be interfaced	
  	def generate_js_insert_inside new_node, reference_node_ref
  		return "$([data-uid='#{reference_node_ref}']).append('#{new_node.to_html}');"
  	end
	
  	#generates js code to remove element
  	#TODO: this is js library dependent and should be interfaced
  	def generate_js_remove node_ref
  		return "$([data-uid='#{node_ref}']).remove();"
  		#maybe detache instead of remove?
  	end
	
  end
end