Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   # #index
   get('/', { to: 'ideas#index', as: 'root'})
   # # new
   get('/ideas/new', { to: 'ideas#new', as: :new_idea })
   # create
   post('/ideas', { to: 'ideas#create' })
   #show
   get('/ideas/:id', { to: 'ideas#show', as: :idea })
   #edit
   get('/ideas/:id/edit', { to: 'ideas#edit', as: :edit_idea })
   #update
   patch('/ideas/:id', { to: 'ideas#update'})
   #delete
   delete('/ideas/:id', { to: 'ideas#destroy'})
   #resources :ideas

   resources :ideas do
    # create => post '/ideas/:idea_id/reviews'
    resources :reviews, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
  
   
  
  end
  resources :users, only:[:new, :create, :edit, :update]
  resource :session, only:[:new, :create, :destroy]

  
end
