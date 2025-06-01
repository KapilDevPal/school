Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :school_owners, controllers: {
    sessions: 'school_owners/sessions',
    registrations: 'school_owners/registrations'
  }

  devise_for :students

  root 'pages#landing'

  # School Owner routes
  resource :school_owner, only: [:show, :edit, :update] do
    resources :schools, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    root to: 'dashboard#index'
    resources :schools do
      member do
        patch :update_features
      end
      resource :module_settings, only: [:show, :update]
    end
    resources :plans
    resources :users
  end

  namespace :schools do
    resources :students
    resources :teachers do
      resources :salary_structures, only: [:new, :create]
    end
    resources :salary_structures do
      member do
        get :download
        patch :mark_as_paid
      end
    end
    resources :payslips do
      member do
        get :download
        patch :mark_as_paid
      end
    end
    resources :classes
    resources :subjects
    resources :timetables
    resources :attendance_records, only: [:index]
    resources :teacher_attendances
    resources :notices
    resources :fees
    resources :inventory_items do
      resources :inventory_transactions, only: [:new, :create]
    end
    resources :transport
    resources :calendar
    resources :students
    resources :teachers
    resources :school_classes
    resource :module_settings, only: [:show, :update]
    resources :exams
  end

  namespace :teacher do
    resources :classes
    resources :attendance
    resources :timetables
    resources :subjects
  end

  namespace :student do
    resources :dashboard
    resources :timetables
    resources :subjects
    resources :attendance
    resources :fees
    resources :notices
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Dashboard route
  get 'dashboard', to: 'dashboard#index', as: :dashboard
end
