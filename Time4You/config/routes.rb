Time4You::Application.routes.draw do

  resources :brands

	get ':controller/change_order' => ':controller#change_order'
	get ':controller/change_page' => ':controller#change_page'
	get ':controller/filter_search' => ':controller#filter_search'

	match "/logout" => "sessions#logout"
	match "/login" => "sessions#login"
	match "/my_profile" => "users#my_profile"	
	match "/admin_update" => "users#admin_update"

	
	resources :users, :sessions do
	  collection do
			get :check_ajax
		end
	end
  
  resources :users

 
    root :to => 'sessions#login'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
