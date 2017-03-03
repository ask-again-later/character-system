Rails.application.routes.draw do
  devise_for :users

  root to: 'characters#index'

  get 'characters/wizard', to: 'characters#wizard', as: 'new_character_wizard'
  resources :characters
  get 'characters/:id/wizard/:page', to: 'characters#wizard_questionnaire'
  get 'characters/:id/wizard/basics', to: 'characters#wizard_basics'
  get 'characters/:id/wizard/skills_trainings', to: 'characters#wizard_skills_trainings'
  get 'characters/:id/wizard/challenges_advantages', to: 'characters#wizard_challenges_advantages'
  post 'characters/wizard', to: 'characters#wizard_router', as: 'wizard_update'

  namespace :api do
    get 'characters', to: 'characters#index'
    get 'characters/:id', to: 'characters#show'

    get 'advantages', to: 'advantages#index'
    get 'advantages/:id', to: 'advantages#show'

    get 'challenges', to: 'challenges#index'
    get 'challenges/:id', to: 'challenges#show'
  end

  namespace :admin do
    get '/', to: 'settings#index'
    post '/', to: 'settings#update'
  end

  namespace :storytellers do
    get '/', to: 'dashboard#index'
    resources :advantages
    resources :challenges
    resources :true_selves
    get '/questionnaire', to: 'questionnaire_items#index'
    post '/questionnaire', to: 'questionnaire_items#update'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
