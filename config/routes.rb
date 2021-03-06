Rails.application.routes.draw do

  devise_for :users, controllers:{ sessions: 'users/sessions',
  registrations: 'users/registrations'
  }

  get 'welcome#index' => redirect("/")
  get 'domov' => 'home#index'
  get 'admin' => 'admin#index'

  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  post 'users/invite' => 'users#invite'
  put 'user/:id' => 'users#update'

  get 'message/create'
  get 'message/:id' => 'room#get_message'

  resources :room, path: 'miestnosti', only: [:show, :index, :update, :destroy, :create]
  get 'miestnosti_list' => 'room#list'
  get 'miestnosti_list/:id' => 'room#open_room'
  post 'miestnosti_list/:id' => 'room#close_room'
  get 'miestnosti_ppl' => redirect('/')
  get 'miestnosti_ppl/:id' => 'room#manage_people'
  post 'add_player/:user/:room' => 'room#add_player'
  post 'add_spectator/:user/:room' => 'room#add_spectator'
  post 'remove_player/:user/:room' => 'room#remove_player'

  resources :location, only: [:create, :destroy, :update]
  get 'available_locations/:room' => 'location#available_locations'
  post 'switch_location/:room/:location' => 'location#switch'
  post 'temporary_location/:room' => 'location#create_temporary'

  post 'character' => 'character#create'
  post 'character/:id' => 'admin#activate'
  get 'character/switch/:id' => 'character#switch_current'

  root to: "welcome#index"
end
