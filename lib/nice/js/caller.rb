module Nice
	module Js
		class Caller

			# DOM Manipulation
			def self.generate_js_insert_after new_node, reference_node_ref
				"dispatch_event(\'nice.dom.InsertAfterEvent\',{new_node:\'#{new_node}\', ref_node:\"#{reference_node_ref}\"});"
			end

			def self.generate_js_insert_inside new_node, reference_node_ref
				"dispatch_event(\'nice.dom.InsertInsideEvent\',{new_node:\'#{new_node}\', ref_node:\"#{reference_node_ref}\"});"			
			end

			def self.generate_js_remove curr_state
				"dispatch_event(\'nice.dom.RemoveStateEvent\',{curr_state:\'#{curr_state}\'});"				
			end


			# History Manipulation
			def self.move_to_url url, title
				"dispatch_event(\'nice.hist.ChangeURLEvent\',{url:\'#{url}\', title:\'#{title}\'});"
			end

			def self.insert_or_update_back_listener url
				"dispatch_event(\'nice.hist.PopHistoryEvent\',{url:\'#{url}\'});"
			end
		end
	end
end