require 'test_helper'

class NiceTest < ActionDispatch::IntegrationTest
  #fixtures :all
 
  # Replace this with your real tests.
  test "initial call to a Nice driven application" do
	visit "books"
  end

end
