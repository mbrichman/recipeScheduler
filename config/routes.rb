ReceipeScheduler::Application.routes.draw do
  get '/recipes', :controller => 'Recipes', :action => 'index', :as => 'all_recipes'
  
  get '/recipes/:id', :controller => 'Recipes', :action => 'show', :as => 'recipe'
  
  get '/', controller: 'Recipes', action: 'home', as: 'root'
  
  post '/parse', controller: 'Recipes', action: 'parse'
end
