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

      doc
    end

  	def self.add_elements_of_current_state doc, curr_state

  		# get all nodes of the current state
  		curr_state_nodes = doc.css("[data-state='#{curr_state}']")

  		# get reference nodes in DOM tree for current nodes and generate js insert statements
  		stack = curr_state_nodes.map do |curr_node|

  			ref_node_name = "[data-state-uid~=\'#{curr_node['data-state']}_ref\']"  			
  			ref_node = doc.css(ref_node_name)

  			ref_node_method = ref_node != nil ? ref_node.attribute('data-state-insert-method').value : "insert"

  			if ref_node_method == "insert"
  				js_text = "$(\"#{ref_node_name}\").insert(\'#{curr_node}\');"		
  			else
  				js_text = "$(\"#{ref_node_name}\").append(\'#{curr_node}\');"
  			end

  			# remove unuseful chars which will break the js parser
  			js_text = js_text.gsub(/(\r\n|\n|\r|\t)/,'')
  		end

  		stack
  	end

  	# generates nodes for all "data-state" elements
  	def self.annotate_referencing_nodes doc

  		doc.css("[data-state]").each do |curr_node|
  			
  			if curr_node.previous_element && !curr_node.previous_element.has_attribute?("data-state") then
  				node = curr_node.previous_element
  				method = "insert"
  			else
  				node = curr_node.parent
  				method = "append"
  			end
  			
  			p "node: #{node != nil}"
  			p "node method: #{method}"

  			continue if node == nil

  			a = node.has_attribute?('data-state-uid') ? [node.attribute('data-state-uid').value] : []
			a += [self.ref_node_uid(curr_node['data-state'])]
			node['data-state-uid'] = a.join(" ")

			m = node.has_attribute?('data-state-insert-method') ? [node.attribute('data-state-insert-method').value] : []
			m += ["insert"]
			node['data-state-insert-method'] = m.join(" ")
  		end

  		doc
  	end
	
	
  	private
	
  	def self.ref_node_uid (node_uid)
  		"#{node_uid}_ref"
  	end

  	#generates js code to insert 'new_node' after 'reference_node'
  	#TODO: this is js library dependent and should be interfaced	
  	def self.generate_js_insert_after new_node, reference_node_ref
  		return "$(\"[data-uid='#{reference_node_ref}']\").insert(\"#{new_node.to_html}\");"
  	end

  	#generates js code to insert 'new_node' inside 'reference_node'
  	#TODO: this is js library dependent and should be interfaced	
  	def self.generate_js_insert_inside new_node, reference_node_ref
  		return "$(\"[data-uid='#{reference_node_ref}']\").append(\"#{new_node.to_html}\");"
  	end
	
  	#generates js code to remove element
  	#TODO: this is js library dependent and should be interfaced
  	def self.generate_js_remove node_ref
  		return "$([data-uid='#{node_ref}']).remove();"
  		#maybe detache instead of remove?
  	end
	
  end
end