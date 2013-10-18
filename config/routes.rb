GameHall::Application.routes.draw do

	

	namespace :tmu_admin do
		resources :users do
			member do
				patch :update_password, :reset_password
			end
		end

		resource :user_session
		resource :password_reset, :only => [:create, :edit, :update]
		resources :active_devices
		resources :apps 
		resources :rooms 
		resources :players

		post "active_devices/data" => "active_devices#data"
		post "apps/data" => "apps#data"
		post "rooms/data" => "rooms#data"
		post "players/data" => "players#data"
		post "users/data" => "users#data"

		post "rooms/search" => "rooms#search"

		get "/dashboard" => "tmu_admin#dashboard"
		root :to => "tmu_admin#index"
	end

	get "download/test" => "download#test"
	get "download/package" => "download#package"
	get "download/image" => "download#image"
	get "active/device" => "active#device"
	
	post "regist/quick" => "regist#quick"
	post "regist/normal" => "regist#normal"
	post "login/login" => "login#login"
	post "login/:appid/app" => "login#app"
	post "apps" => "apps#list"
	post "apps/:appid/rooms" => "apps#rooms"
	post "deposit/cash" => "deposit#cash"
	
	get "/admin" => redirect("/tmu_admin")
end
