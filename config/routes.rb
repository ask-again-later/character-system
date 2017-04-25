Rails.application.routes.draw do
  devise_for :users

  root to: 'characters#index'

  get 'characters/wizard', to: 'characters#wizard', as: 'new_character_wizard'
  get 'characters/print_all_mechanics', to: 'characters#print_all_mechanics', as: 'characters_print_mechanics'
  get 'characters/print_all', to: 'characters#print_all', as: 'characters_print'
  resources :characters
  get 'characters/:id/wizard', to: 'characters#wizard', as: 'character_wizard'
  get 'characters/:id/wizard/basics', to: 'characters#wizard_basics'
  get 'characters/:id/wizard/skills_trainings', to: 'characters#wizard_skills_trainings'
  get 'characters/:id/wizard/challenges_advantages', to: 'characters#wizard_challenges_advantages'
  get 'characters/:id/wizard/:page', to: 'characters#wizard_questionnaire', as: 'character_wizard_page'
  get 'characters/:id/print', to: 'characters#print', as: 'character_print'
  post 'characters/wizard', to: 'characters#wizard_router', as: 'wizard_update'
  post 'characters/send_approvals', to: 'characters#send_approvals', as: 'send_approvals'

  namespace :api do
    get 'characters', to: 'characters#index'
    get 'characters/:id', to: 'characters#show'

    get 'advantages', to: 'advantages#index'
    get 'advantages/:id', to: 'advantages#show'

    get 'challenges', to: 'challenges#index'
    get 'challenges/:id', to: 'challenges#show'

    get 'true_selves', to: 'true_selves#index'
    get 'true_selves/:id', to: 'true_selves#show'
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
    post 'reorder_questionnaire', to: 'questionnaire_sections#reorder_sections', as: 'reorder_questionnaire_sections'
    resources :questionnaire_sections
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
