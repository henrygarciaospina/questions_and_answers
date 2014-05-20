Rails.application.routes.draw do
  root "home#about"

  get "/about_us"           => "home#about"
  get "/faq"                => "faq#index"
  get "/help"               => "help#index"

  get "/questions"          => "questions#index"
  post "/questions"         => "questions#create"
  get "/questions/:id"      => "questions#show"
  get "/questions/:id/edit" => "questions#edit"
  match "/questions/:id"    => "questions#update", via: [:put, :patch]
  delete "/questions/:id"   => "questions#destroy"

  resources :questions do
    member do
      post :vote_up
      post :vote_down
    end
    post :search, on: :collection
  end

end
