Rottenpotatoes::Application.routes.draw do
  root :to => "movies#index"
  resources :movies
  post '/movies/search_tmdb'
end
