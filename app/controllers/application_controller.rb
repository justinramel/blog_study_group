class ApplicationController < ActionController::Base
	# ...
	before_filter :init_blog
	private
	def init_blog
		@blog = THE_BLOG
	end
end

