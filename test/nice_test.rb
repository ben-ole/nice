require 'test_helper'

class NiceTest < ActionController::IntegrationTest

  	  def test_trial_account_sign_up
	    visit home_path
	    click_link "Sign up"
	    fill_in "Email", :with => "good@example.com"
	    select "Free account"
	    click_button "Register"
	  end
end
