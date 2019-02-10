Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      resources :posts
      resources :comments
      resources :users
    end
  end

  resources :users, only: [:index, :edit, :update]

  post "/upload_avatar", to: "users#upload_avatar", as: "upload"
end
