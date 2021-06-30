Rails.application.routes.draw do
  resources :todos, except: [:destroy]
  delete '/todos', to: 'todos#destroy_all', as: 'destroy_todos'
end
