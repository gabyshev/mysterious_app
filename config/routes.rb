Rails.application.routes.draw do
  def api_version(version, &routes)
    api_constraint = ApiConstraint.new(version: version)
    scope(
      module: "v#{version}",
      defaults: { format: :json },
      constraints: api_constraint, &routes
    )
  end

  api_version(1) do
    devise_for :users, controllers: {
      sessions:      'v1/users/sessions',
      registrations: 'v1/users/registrations'
    }, only: [:sessions, :registrations]

    resources :blog_posts, except: [:new, :edit] do
      resources :comments, only: [:create, :destroy]
    end
  end
end
