require 'test_helper'

class NiceTest < ActionDispatch::IntegrationTest
  #fixtures :all

  test "HTML response should not contain any non relevant state elements" do
	# given we make a initial call
	visit a_basic_index_path

	# then the html response should not contain any elements only owned by other states
	assert_have_no_selector "[data-state]:not([data-state~=get_basic_a])"
  end  

end