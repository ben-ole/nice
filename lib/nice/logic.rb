require 'nice/html_parser'
require 'nice/js/caller'
require 'uri'

module Nice

	# The nice state engine is tighthly integrated with restful routes. Each route can be a state
	# and states are only identified by their corresponding route. In effect, no state names
	# must be created and no parameters indicating the state transitions are needed as this
	# information is already contained in the http header.

    ## case 1: this is the first call of the component -> no previous state
		
		# => 	remove elements not belonging to the start state, generate UID for reference
		#		nodes ({ref_element}_ref) and respond with HTML
		
	## case 2: this is an ordinary call of another state
		
		# => 	respond with JS with assignments to remove elements not included
		#		in current state and assignments to insert elements of current state.
		
		
	## case 3: curr_state == prev_state 
		
		# => 	respond with JS which either first removes all elements of the current state and
		#		later inserts new content OR directly replaces elements
		
	## case 4: the controller changed
	  # => replace all contents under the "container yield" mentioned in the application layout file
	
  class Logic
    
    def self.run current_method, current_path, referer, doc, is_js

        ref_c = Rails.application.routes.recognize_path(referer)[:controller]
        ref_a = Rails.application.routes.recognize_path(referer)[:action]
    	  curr_c = Rails.application.routes.recognize_path(current_path)[:controller]
    	  curr_a = Rails.application.routes.recognize_path(current_path)[:action]
    	
    	  current_state = "#{current_method.downcase}_#{curr_c}_#{curr_a}"
    	
    	  prev_state = referer.gsub("/","_") unless referer.nil?

      	referenced_doc = Nice::HtmlParser.annotate_referencing_nodes doc	

      	cleaned_doc = Nice::HtmlParser.remove_elements_not_of_state current_state, referenced_doc
      	
      	controller_same = (ref_c == curr_c)
      	
      	# case 1
      	if !is_js then   

          response = Nice::HtmlParser.add_top_css(cleaned_doc, current_state).to_html

      	# case 2
      	elsif controller_same && is_js then   
      		js_stack = ["// remove elements not present in the following state"]
      		js_stack << Nice::Js::Caller.generate_js_remove(current_state)

      		js_stack << "// add new elements"
      		js_stack += Nice::HtmlParser.add_elements_of_current_state(cleaned_doc,current_state).compact
      		
      	# case 4
      	elsif !controller_same && is_js then
      		js_stack = ["// remove elements not present in the following state"]
      		js_stack << Nice::Js::Caller.generate_js_remove(current_state)
      		      	  
          js_stack << ["// remove elements below root"]
      		js_stack << Nice::Js::Caller.clean_root_tree
      		
      		js_stack << "// add new content tree blow root tag"
      		js_stack += Nice::HtmlParser.add_root_content(cleaned_doc).compact
      		
      		js_stack << "// add elements of the current state above root"
      		js_stack += Nice::HtmlParser.add_elements_of_current_state(cleaned_doc,current_state,true).compact      		
      	end
      	
      	# add completing js 
      	if is_js then
      	  js_stack << "// add browser history scripts"		
      		js_stack << Nice::Js::Caller.move_to_url(current_path,"title")
      		js_stack << Nice::Js::Caller.insert_or_update_back_listener(referer)

      		js_stack << "// inform ui on state change"
      		js_stack << Nice::Js::Caller.state_did_change(prev_state,current_state)

          js_stack << "// switch body css class"      		
      		js_stack << Nice::Js::Caller.change_top_css(current_state)
      		
      	  js_stack << "// AJAX RAILS ENGINE (nice.codebility.com)"		      		
      		      		
      		response = js_stack.join("\n")
      	end
      	
      	response
    end
    
  end
end