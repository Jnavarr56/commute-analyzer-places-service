# frozen_string_literal: true

Rails.application.routes.draw do
  prefix = Constants::ROUTE_PREFIX.is_a?(String) ? Constants::ROUTE_PREFIX : '/'

  scope path: prefix, constraints: { format: 'json' } do
    resources :favorites
    resources :apartments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
