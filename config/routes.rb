Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users

  authenticate :admin_user do
    match "/delayed_job" => DelayedJobWeb, anchor: false, via: %i(get post)

    namespace :admin do
      resources :snap_applications, only: %i[index show] do
        get "pdf", on: :member
      end
      resources :medicaid_applications, only: %i[index show] do
        get "pdf", on: :member
      end
      resources :common_applications, only: %i[index show] do
        get "pdf", on: :member
      end
      resources :exports, only: %i[index show]
      resources :members, only: %i[index show]
      resources :employments, only: %i[index show]
      resources :addresses, only: %i[index show]
      resources :household_members, only: %i[index show]

      root to: "snap_applications#index"
    end
  end

  resources :messages

  get "/start" => "static_pages#index"
  root "static_pages#index"
  get "/privacy" => "static_pages#privacy"
  get "/terms" => "static_pages#terms"
  if GateKeeper.feature_enabled? "FLOW_CLOSED"
    get "/clio" => redirect("/")
    get "/union" => redirect("/")
  else
    get "/clio" => "static_pages#clio"
    get "/union" => "static_pages#union"
  end

  resource :confirmations, only: %i[show]
  resources :documents, only: %i[index new create destroy]

  if Rails.env.test? || Rails.env.development?
    resource :file_preview, only: %i[show]
  end

  resources :numbers, module: :stats, only: %i[index]

  resource :resource, only: %i[show]
  resource :sessions, only: %i[new destroy] do
    collection do
      get :clear, to: "sessions#destroy"
    end
  end

  resource :skip_send_application, only: [:create]

  resources :steps, only: %i[index show] do
    collection do
      StepNavigation.steps_and_substeps.each do |controller_class|
        { get: :edit, put: :update }.each do |method, action|
          match "/#{controller_class.to_param}",
            action: action,
            controller: controller_class.controller_path,
            via: method
        end
      end

      Medicaid::StepNavigation.steps_and_substeps.each do |controller_class|
        { get: :edit, put: :update }.each do |method, action|
          match "/#{controller_class.to_param}",
            action: action,
            controller: controller_class.controller_path,
            via: method
        end
      end
    end
  end

  resources :sections, controller: :forms, only: %i[index show] do
    collection do
      FormNavigation.all.each do |controller_class|
        { get: :edit, put: :update }.each do |method, action|
          match "/#{controller_class.to_param}",
            action: action,
            controller: controller_class.controller_path,
            via: method
        end
      end
    end
  end

  resource :feedback, only: %i[create]
end
