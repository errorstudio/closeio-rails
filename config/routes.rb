Closeio::Rails::Engine.routes.draw do
  resources :webhooks, only: [:create], defaults: { format: :json } do
    collection do
      scope constraints: ->(request){ Rails.env.development? } do
        get "/debug", to: "webhooks#debug"
      end
    end
  end
end