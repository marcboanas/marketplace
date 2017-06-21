require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, "Neil Cochrane"
		assert_equal full_title("Help"), "Help | Neil Cochrane"
	end
end