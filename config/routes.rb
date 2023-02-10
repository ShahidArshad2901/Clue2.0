Rails.application.routes.draw do
  root to: 'clues#index'
  get 'clues/index'
  get 'clues/quiz'
  post 'question_response', to: 'clues#question_response'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
