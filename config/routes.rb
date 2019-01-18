ActionController::Routing::Routes.draw do |map|

  map.resources :users
  map.resources :doctors, :collection => { :show_appointments => :get, :show_patients => :get, :show_timeslots => :get, :show_slots => :get, :show_profile => :get}
  map.resources :patients, :collection => { :get_appointments => :get, :get_record => :get, :show_appointments => :get, :show_profile => :get}
  map.resources :admins, :collection => { :show_patients => :get, :show_doctors => :get, :show_appointments => :get, :show_patientrecords => :get, :list_beds => :get}, :member => {:destroy_appointment => :post}
  map.resources :departments, :collection => { :show_doctors => :get}
  map.resources :rooms, :has_many => :beds
  map.resources :timeslots, :collection => { :list_doctors => :get}
  map.resources :medical_records
  map.resources :admits, :collection => { :list_beds => :get, :discharge_patient_form => :get, :upload_record => :get}
  map.resources :records

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.root :controller => 'sessions' , :action => 'new'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
