Rails.application.routes.draw do
  devise_for :users, controllers:{ sessions: 'users/sessions',
                                   registrations: 'users/registrations'
  }

  get 'welcome#index' => redirect("/")
  get 'domov' => 'home#index'
  get 'admin' => 'admin#index'

  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'

  resources :room, path: 'miestnosti', only: [:show, :index, :update, :destroy, :create]

  post 'character' => 'character#create'
  post 'character/:id' => 'admin#activate'
#  resources :character, path: 'postavy', only: [:show, :index, :update, :destroy, :create]

#  get 'miestnosti' => 'room#index'
#  post 'miestnosti' => 'room#create'
#  patch 'miestnost/:id' => 'room#update'
#  delete 'miestnost/:id' => 'room#destroy'
#  get 'miestnost/:id' => 'room#show'

  get ':id' => redirect("/")

  root to: "welcome#index"
end
