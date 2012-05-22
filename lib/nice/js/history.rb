module Nice
	module Js
		class History
			def self.move_to_url url, title
				"history.pushState(null,\"#{title}\",\"#{url}\");"
			end

			def self.insert_or_update_back_listener url
				"$(window).unbind(\"popstate\"); \
				 $(window).bind(\"popstate\", function () {\
					    var xmlHttp = null;

					    xmlHttp = new XMLHttpRequest();
					    xmlHttp.open( \"GET\", \"#{url}\", false );
					    xmlHttp.send( null );
					    
					    eval(xmlHttp.responseText);
					});"
			end
		end
	end

end