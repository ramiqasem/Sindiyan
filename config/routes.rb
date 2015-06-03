Rails.application.routes.draw do
  resources :events

  get 'memberships/new'

  get 'memberships/create'

  get 'memberships/delete'

  get 'memberships/index'

  get 'groups/create'

  get 'groups/destroy'

  get 'relationships/create'

  get 'relationships/destroy'

  root             'static_pages#home'
  get 		'help'    => 'static_pages#help'
  get 		'about'   => 'static_pages#about'
  get 		'contact' => 'static_pages#contact'
  get 		'signup' => 'users#new'
  get   	'login'   => 'sessions#new'
  post 		'login'   => 'sessions#create'
  delete 	'logout'  => 'sessions#destroy'
  get     'join'    => 'memberships#new'
  get     'test'    => 'static_pages#test'
  get     'reset_group' => 'users#reset_group'


  resources :users do
    member do
      get :following, :followers

    end
  end
  resources :account_activations, only: [:edit]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :groups
  resources :memberships

  match "/microposts/add_new_comment" => "microposts#add_new_comment", :as => "add_new_comment_to_microposts", :via => [:post]
  

end