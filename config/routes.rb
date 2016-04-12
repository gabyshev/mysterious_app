Rails.application.routes.draw do
  scope 'api/v1', defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
  end
end
