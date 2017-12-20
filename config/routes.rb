Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'sites#show'

  resources :products do
    resources :product_details
    resources :product_categories
    resources :product_photos
    collection do
      post :send_product_to_site
    end
  end

  resources :carts do
    resources :cart_items
  end

  resources :cart_items do
    collection do
      post :remove_item
    end
  end

  resources :brands do
    collection do
      post :cat_to_brand
    end
  end

  resources :transactions
  resources :sites
  resources :admin
  resources :charges do
    collection do
      post :create
    end
  end

  resources :brands do
    collection do
      post :send_brand_to_site
    end
  end
  resources :categories do
    collection do
      put :update
      post :send_category_to_site
    end
  end

  get '/products/page/:page' => 'products#index'
  get '/categories' => 'categories#index'
  get '/login' => 'admin#login'
  get '/categories/:id/page/:page' => 'categories#show'
  get ':site' => 'sites#show'
  get ':site/categories' => 'categories#index'
  get ':site/categories/:category' => 'categories#show'
  get ':site/products/:product' => 'products#show'
  get '/admin/sites/:site' => 'admin#index'
  get '/admin/sites/:site/brands' => 'admin#brands'
  get '/admin/sites/:site/categories' => 'admin#categories'
  get '/brands/:id/page/:page' => 'brands#show'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
