Rails.application.routes.draw do

  devise_for :users, controllers:{ sessions: 'users/sessions',
                                   registrations: 'users/registrations'
  }

  get 'welcome#index' => redirect("/")
  get 'domov' => 'home#index'

  #upravit / rozbit na mensie nech sa nebije s root
  #resources :room, path: '/'

  get 'miestnosti' => 'room#index'
  post 'miestnosti' => 'room#create'
  patch ':id' => 'room#update'
  delete ':id' => 'room#destroy'
  get ':id' => 'room#show'

  root to: "welcome#index"
end
