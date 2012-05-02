require 'nice/html_parser'

module Nice
  
  ## case 1: this is the first call of the component -> no previous state
	
	# => 	remove elements not belonging to the start state, generate UID for reference
	#		nodes ({ref_element}_ref) and respond with HTML
	
	## case 2: this is an ordinary call of another state
	
	# => 	respond with JS with assignments to remove elements not included
	#		in current state and assignments to insert elements of current state.
	
	
	## case 3: curr_state == prev_state 
	
	# => 	respond with JS which either first removes all elements of the current state and
	#		later inserts new content OR directly replaces elements
	
  class Logic
    
    def self.run state_pass, doc
      if state_pass == nil then
        resp = Nice::HtmlParser.remove_elements_not_of_state "one", doc
      end
    end
    
  end
end