require 'nokogiri'
require 'nice/logic'

module Nice
  class Middleware
    
    ## case 1: this is the first call of the component -> no previous state
		
		# => 	remove elements not belonging to the start state, generate UID for reference
		#		nodes ({ref_element}_ref) and respond with HTML
		
		## case 2: this is an ordinary call of another state
		
		# => 	respond with JS with assignments to remove elements not included
		#		in current state and assignments to insert elements of current state.
		
		
		## case 3: curr_state == prev_state 
		
		# => 	respond with JS which either first removes all elements of the current state and
		#		later inserts new content OR directly replaces elements
		
    
    def initialize(app)
      @app = app
    end
  
    def call(env)
      @doc = nil
      status, @headers, @body = @app.call(env)
      
      if html?
        [status, @headers, self]
      else
        [status, @headers, @body]
      end
    end
    
    def each(&block)
      if html?
        block.call("<!-- Nice State Engine, awesome! -->\n")
        block.call( Nice::Logic.run( nil, doc ) )
      else
        block.call(@body)
      end
    end
    
    # Helper
    private 
    
    def html?
      @headers["Content-Type"] && @headers["Content-Type"].include?("text/html")
    end
    
    def doc
      @doc ||= Nokogiri::HTML(body_to_string)
    end
  
    def body_to_string
      s = ""
      @body.each { |x| s << x }
      s
    end
    
    def update_content_length
      @headers['Content-Length'] = Rack::Utils.bytesize(@body).to_s
    end    
  end
end