require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout_links" do
  	get root_path
  	assert_template 'static_pages/home'
  	assert_select "a[href=?]", root_url, count: 1
  	assert_select "a[href=?]", signup_path, count: 1
  	get faq_path
  	assert_select "title", full_title("Help")
  	get signup_path
  	assert_select "title", full_title("Register")
  end
end
