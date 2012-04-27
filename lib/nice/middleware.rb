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
      @status, @headers, @response = @app.call(env)
      
      if @headers["Content-Type"].include? "text/html"
        [@status, @headers, self]  
      else
        [@status, @headers, @response]
      end
    end
  
    def each(&block)
      if @headers["Content-Type"].include? "text/html"
        block.call("<!-- Nice State Engine, awesome! -->\n")
        NiceStateEngine::HtmlParser.remove_elements_of_state( "one", @response.each(&block) )
      end
    end
  end
end