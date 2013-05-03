ReceipeScheduler::Application.routes.draw do
  get '/', controller: 'Recipes', action: 'home', as: 'root'

  get '/recipes', :controller => 'Recipes', :action => 'index', :as => 'all_recipes'

  get '/recipes/:id', :controller => 'Recipes', :action => 'show', :as => 'recipe'


  post '/parse', controller: 'Recipes', action: 'parse'

  post '/recipes', controller: 'Recipes', action: 'create', as: 'new_recipe'

  get '/search', controller: 'Recipes', action: 'search', as: 'search_recipe'
end
