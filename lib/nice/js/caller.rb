module Nice
	module Js
		class Caller

			# DOM Manipulation
			def self.generate_js_insert_after new_node, reference_node_ref
				"NiceEventDispatcher.dispatch_event(\'nice.dom.InsertAfterEvent\',{new_node:\'#{new_node}\', ref_node:\"#{reference_node_ref}\"});"
			end

			def self.generate_js_insert_inside new_node, reference_node_ref
				"NiceEventDispatcher.dispatch_event(\'nice.dom.InsertInsideEvent\',{new_node:\'#{new_node}\', ref_node:\"#{reference_node_ref}\"});"			
			end

			def self.generate_js_remove curr_state
				"NiceEventDispatcher.dispatch_event(\'nice.dom.RemoveStateEvent\',{curr_state:\'#{curr_state}\'});"				
			end


			# History Manipulation
			def self.move_to_url url, title
				"NiceEventDispatcher.dispatch_event(\'nice.hist.ChangeURLEvent\',{url:\'#{url}\', title:\'#{title}\'});"
			end

			def self.insert_or_update_back_listener url
				"NiceEventDispatcher.dispatch_event(\'nice.hist.PopHistoryEvent\',{url:\'#{url}\'});"
			end

			# events for UI
			def self.state_did_change prev_state, new_state
				"NiceEventDispatcher.dispatch_event(\'nice.ui.StateDidChangeEvent\',{prev_state:\'#{prev_state}\', new_state:\"#{new_state}\"});"
			end
			
			# State Transition Animations
			def self.perform_transition_animations
			  "NiceEventDispatcher.dispatch_event(\'nice.trsn.AnimateEvent\');"
			end
			
		end
	end
end