require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference "User.count" do
  		post signup_path, params: { user: {name: "", email: "user.invalid", password: "123", password_confirmation: "456"} }
  	end
  	assert_template "users/new"
  	assert_select 'div#error_explanation', count: 1
  	assert_select 'div.field_with_errors', count: 8
  	assert_select 'form[action=?]', signup_path, count: 1
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Example User",
        email: "user@example.com", password: "123456", password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_select 'div.flash.success', count: 1, text: "User was successfully created."
  end
end
