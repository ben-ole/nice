require 'nice/js/dom_manipulation_jquery'

module Nice
	module Js
		class DomManipulation

			def self.generate_js_insert_after new_node, reference_node_ref
				return self.target.generate_js_insert_after new_node, reference_node_ref
			end

			def self.generate_js_insert_inside new_node, reference_node_ref
				return self.target.generate_js_insert_inside new_node, reference_node_ref
			end

			def self.generate_js_remove
				return self.target.generate_js_remove
			end
	 
			protected

	        def self.target
	          @@t ||= Nice::Js::DomManipulationJquery.new if defined? JS_METHOD && JS_METHOD == "JQUERY"

	          # otherwise default
	          @@t || (new Nice::Js::DomManipulationJquery)
	        end
		end
	end
end