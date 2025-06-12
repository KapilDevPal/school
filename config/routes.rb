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
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # Custom login routes within devise_scope
  devise_scope :user do
    get 'login/teacher', to: 'users/sessions#new_teacher', as: :teacher_login
    get 'login/student', to: 'users/sessions#new_student', as: :student_login
  end

  # Admin routes
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
    resources :school_classes
    resources :teachers
    resources :students
    resources :subjects
    resources :exams
    resources :assignments
    resources :attendance
    resources :timetables
    resources :leave_applications
    resources :teaching_materials
    resources :notices
    resources :profile, only: [:show, :edit, :update]
  end

  # School Owner routes
  namespace :schools do
    root to: 'dashboard#index'
    resources :schools do
      resources :students
      resources :teachers do
        resources :salary_structures, only: [:new, :create] do
          member do
            get :download
            patch :mark_as_paid
          end
        end
      end
     resources :classes, controller: 'classes'
      resources :subjects
      resources :exams
      resources :notices
      resources :fees
    end
    resources :salary_structures do
      member do
        get :download
        patch :mark_as_paid
      end
    end
    resources :timetables
    resources :attendance_records, only: [:index]
    resources :teacher_attendances
    resources :fees
    resources :inventory_items do
      resources :inventory_transactions, only: [:new, :create]
    end
    resources :transport
    resources :calendar
    resources :exams
    resource :module_settings, only: [:show, :update]
    resources :leave_applications, only: [:index, :show] do
      member do
        post :approve
        post :reject
      end
    end
  end

  # Teacher routes
  namespace :teachers do
    root to: 'dashboard#index'
    resources :attendance, only: [:index, :create, :update]
    resources :timetables, only: [:index, :show]
    resources :leave_applications
    resources :teaching_materials
    resources :student_progress, only: [:index, :show]
    resources :notices, as: 'teacher_notices'
    resources :school_classes, only: [:index, :show]
    resource :profile, only: [:show, :edit, :update]
  end

  # Student routes
  namespace :student do
    root to: 'dashboard#index'
    resources :academic_progress, only: [:index, :show]
    resources :timetables, only: [:index]
    resources :notices, only: [:index, :show]
    resources :fees, only: [:index, :show]
    resources :profile, only: [:show, :edit, :update]
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get 'school_owner', to: 'school_owners#show'
  resources :school_owners, only: [:show, :edit, :update]
end
