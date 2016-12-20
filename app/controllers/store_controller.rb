class StoreController < ApplicationController
	def index
		@products = Product.order(:title)
		
		if session[:count].nil?
			session[:count] = 0
		else
			session[:count] += 1
		end
		
		@access_count = session[:count]
	end
end