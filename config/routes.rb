Rails.application.routes.draw do
  resources :line_items
  resources :carts
	get 'store/index'
	resources :products
	
	# You can have the root of your site routed with 'root'
	# Just remember to delete public/index.html
	root to: 'store#index', as: 'store'
end