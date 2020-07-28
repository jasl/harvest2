# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :projects do
    scope module: :projects do
      resources :tables do
        scope module: :tables do
          resources :relationships, only: %i[index]
          resources :records do
            collection do
              post :generate
            end
          end
          resources :columns, except: %i[index show] do
            scope module: "columns" do
              resource :value_options, only: %i[edit update]
              resource :validation_options, only: %i[edit update]
              resource :storage_options, only: %i[edit update]
            end
          end
        end

        collection do
          post :generate
        end
      end
    end
  end

  get "401", to: "errors#unauthorized", as: :unauthorized
  get "403", to: "errors#forbidden", as: :forbidden
  get "404", to: "errors#not_found", as: :not_found

  root to: "home#index"
end
