Rails.application.routes.draw do
	devise_for :users
	
  resources :users,only: [:show,:index,:edit,:update]
  
  resources :books do
  	# ↓いいねは1つのbookに対して1回しか行わないためresource(単数形)
  	resource :favorites,only: [:create, :destroy]
  	# ↓コメントは1つのbookに対して複数回行うためresources(複数形)
  	resources :book_comments,only: [:create, :destroy]
  end

  root 'home#top'
  get 'home/about'

end
