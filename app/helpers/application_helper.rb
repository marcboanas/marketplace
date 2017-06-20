module ApplicationHelper

	# Returns a dynamic page title
	def full_title(page_title = '')
		base_title = "Neil Cochrane"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end
end
