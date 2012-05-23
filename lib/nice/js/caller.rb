module Nice
	module Js
		class Caller

			# DOM Manipulation
			def self.generate_js_insert_after new_node, reference_node_ref
				"insert_after(\'#{new_node}\',\"#{reference_node_ref}\");"
			end

			def self.generate_js_insert_inside new_node, reference_node_ref
				"insert_inside(\'#{new_node}\',\"#{reference_node_ref}\");"
			end

			def self.generate_js_remove curr_state
				"remove_state_elements(\"#{curr_state}\");"
			end


			# History Manipulation
			def self.move_to_url url, title
				"move_to_url(\"#{url}\",\"#{title}\");"
			end

			def self.insert_or_update_back_listener url
				"insert_or_update_back_listener(\"#{url}\");"
			end
		end
	end
end