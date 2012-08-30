class HomeController < ApplicationController

	before_filter :authorize
	
	def index
		puts "redirecionando para a home"
	end

end
