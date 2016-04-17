Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions:      'v1/users/sessions',
      registrations: 'v1/users/registrations'
    }, only: [:sessions, :registrations]

    resources :blog_posts, except: [:new, :edit]
  end
end
