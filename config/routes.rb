Rails.application.routes.draw do

  devise_for :users, controllers:{ sessions: 'users/sessions',
                                   registrations: 'users/registrations'
  }

  get 'welcome#index' => redirect("/")
  get 'domov' => 'home#index'

  #upravit / rozbit na mensie nech sa nebije s root
  #resources :room, path: '/'

  resources :character, path: ''

  get 'miestnosti' => 'room#index'
  post 'miestnosti' => 'room#create'
  patch 'miestnost/:id' => 'room#update'
  delete 'miestnost/:id' => 'room#destroy'
  get 'miestnost/:id' => 'room#show'

  root to: "welcome#index"
end
