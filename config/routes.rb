Touban::Application.routes.draw do
  root :to => 'top#index'
  get 'next', :to => 'top#next'
  post 'next', :to => 'top#next'
  get 'history', :to => 'top#history'
  match '*path', :to => 'application#error_404'
end
