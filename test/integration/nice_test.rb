require 'test_helper'

class NiceTest < ActionDispatch::IntegrationTest
  #fixtures :all

  test "HTML response should not contain any non relevant state elements" do
	# given we make an initial call
	visit a_basic_index_path

	# then the html response should not contain any elements only owned by other states
	assert_have_no_selector "[data-state]:not([data-state~=get_basic_a])"
  end  

  test "state change should remove all not relevant elements" do
  	# given we make an initial call
  	visit a_basic_index_path

  	# when switching the state from A -> B
  	click_link "State B"

  	# then the resulting page should not contain elements only owned by other states
	assert_have_no_selector "[data-state]:not([data-state~=get_basic_b])"
  end

end