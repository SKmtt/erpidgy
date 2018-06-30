Rails.application.routes.draw do
  get 'message/create'

  devise_for :users, controllers:{ sessions: 'users/sessions',
                                   registrations: 'users/registrations'
  }

  get 'welcome#index' => redirect("/")
  get 'domov' => 'home#index'
  get 'admin' => 'admin#index'

  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  post 'users/invite' => 'users#invite'

  resources :room, path: 'miestnosti', only: [:show, :index, :update, :destroy, :create]
  get 'miestnosti_list' => 'room#list'
  get 'miestnosti_list/:id' => 'room#open_room'
  post 'miestnosti_list/:id' => 'room#close_room'
  # post 'miestnosti/:id' => 'room#saveMessage'

  post 'character' => 'character#create'
  post 'character/:id' => 'admin#activate'
  get 'character/switch/:id' => 'character#switch_current'

  #get ':id' => redirect("/")

  root to: "welcome#index"
end
