Sgsz::Application.routes.draw do

  get 'admin' => 'admin#index'

  controller :session do
    get 'login' => :new 
    post 'login' => :create
    delete 'logout' => :destroy
  end

  #report start 
  match 'sellcostgifts' => 'sellcostgifts#index'


  match 'statementdays' => 'statementdays#index'


  match 'sellcostcustomers' => 'sellcostcustomers#index'


  match 'sellcostproductions' => 'sellcostproductions#index'


  match 'profitshippers' => 'profitshippers#index'


  match 'profitcustomers' => 'profitcustomers#index'


  match 'profitareas' => 'profitareas#index'


  match 'profitproductions' => 'profitproductions#index'


  match 'stockrepairs' => 'stockrepairs#index'


  match 'stocknews' => 'stocknews#index'


  match 'orderstates' => 'orderstates#index'


  match 'orderinshorts' => 'orderinshorts#index'


  match 'delivertypes' => 'delivertypes#index'


  match 'productionpreferences' => 'productionpreferences#index'


  match 'stocktips' => 'stocktips#index'
  #report end


  resources :buylogs


  resources :purchases


  resources :contactpayments


  resources :orderdetails


  resources :ordermains


  resources :afterselldetails


  resources :aftersellmains


  resources :selllogdetails


  resources :selllogmains


  resources :memberprices


  resources :stocks


  resources :shippers


  resources :units


  resources :feeders


  resources :customers


  resources :users


  resources :stores


  resources :mauths


  root :to => 'admin#index'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
