ReceipeScheduler::Application.routes.draw do

  get "recipeboxes/show"

  get "recipebox/show"

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
  resources :menurecipejoins


  # get '/', controller: 'Recipes', action: 'home', as: 'root'
  root :to => 'Recipes#home'

  # Routes for the Menu resource:
  # CREATE
  get '/menus/new', controller: 'menus', action: 'new', as: 'new_menu'
  post '/menus', controller: 'menus', action: 'create'

  # READ
  get '/menus', controller: 'menus', action: 'index', as: 'menus'
  get '/menus/:id', controller: 'menus', action: 'show', as: 'menu'

  # UPDATE
  get '/menus/:id/edit', controller: 'menus', action: 'edit', as: 'edit_menu'
  put '/menus/:id', controller: 'menus', action: 'update'
  put '/menus/recipe/:id', controller: 'menus', action: 'add_recipe', as: 'add_recipe'

  # DELETE
  delete '/menus/:id', controller: 'menus', action: 'destroy'

  get '/menus/:id/cook', controller: 'menus', action: 'cook', as: 'cook_menu'
  #------------------------------


  #CREATE
  post '/recipes', controller: 'Recipes', action: 'create', as: 'new_recipe'

  #READ
  get '/recipes', :controller => 'Recipes', :action => 'index', :as => 'all_recipes'
  get '/recipes/:id', :controller => 'Recipes', :action => 'show', :as => 'recipe'
  get '/recipes/yummly/:id', :controller => 'Recipes', :action => 'show_yummly', :as => 'yummly_recipe'

  #UPDATE
  get '/recipes/:id/edit', controller: 'Recipes', action: 'edit', as: 'edit_recipe'
  # put '/recipes/:id', controller: 'Recipes', action: 'update'

  #SEARCH
  get '/search', controller: 'Recipes', action: 'search', as: 'search_recipe'
  # get '/parse', controller: 'Recipes', action: 'parse'
  get '/import', controller: 'Recipes', action: 'import', as: 'import'
  post '/import', controller: 'Recipes', action: 'add_recipe', as: 'import'

  #DELETE
  delete '/recipes/:id', controller: 'Recipes', action: 'destroy', as: 'recipe'

end
