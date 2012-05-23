module Nice
	module Js
		class DomManipulationJquery
		  	def generate_js_insert_after new_node, reference_node_ref
		  		return "$(\"#{reference_node_ref}\").after(\'#{new_node}\');"
		  	end

		  	def generate_js_insert_inside new_node, reference_node_ref
		  		return "$(\"#{reference_node_ref}\").prepend(\'#{new_node}\');"
		  	end
			
		  	def generate_js_remove curr_state
		  		return "$(\"[data-state]\").not(\"[data-state~=\'#{curr_state}\']\").remove();" +
		  		       "$(\"[data-state~=\'#{curr_state}\'][data-state-update!=\'no\']\").remove();"
		  		#maybe detache instead of remove?
		  	end
		end	
	end
end