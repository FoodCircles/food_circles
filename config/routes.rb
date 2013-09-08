Foodcircles::Application.routes.draw do
  get '/sessions/omniauth_email' => "omniauth_ask_for_email#index", :as => 'omniauth_email'
  put '/sessions/omniauth_email' => "omniauth_ask_for_email#submit", :as => 'omniauth_email_submit'

  get 'reservation/used_email' => 'reservation#used_email'
  get 'reservation/used' => 'reservation#used'
  get 'reservation/active' => 'reservation#active'
  get 'reservation/expired' => 'reservation#expired'
  
  get 'payment/used' => 'payment#used'
  get 'payment/active' => 'payment#active'
  get 'payment/expired' => 'payment#expired'
  get 'payment/inbound_mark_used' => 'payment#inbound_mark_used'
  
  resource :inbox, :controller => 'payment', :only => [:show,:create]

  match '/auth/:provider/callback', :to => 'sessions#create', as: 'callback'

  get "socialbutterflies/index"

  # match '/offers' => 'offers#index', :as => :offers
  resources :offers
  resources :categories
  match '/companies' => 'companies#index', :as => :companies
  match '/nonprofits' => 'nonprofits#index', :as => :nonprofits
  match '/students' => 'students#index', :as => :students
  match '/organizers' => 'organizers#index', :as => :organizers
  match '/restaurants' => 'restaurants#index', :as => :restaurants
  match '/butterflies' => 'socialbutterflies#index', :as => :butterflies
  match '/timeline' => 'timeline#index', :as => :timeline
  #match '/payment' => 'payment#index', :as => :payment
  match '/payment/stripe' => 'payment#stripe', :as => :stripe

  get "user_signup/create"

  resources :stripe_payments, :only =>[:new, :create]

  get "monthly_invoice/monthly_invoice"
  match '/monthly_invoice' => 'monthly_invoice#monthly_invoice', :as => :invoice
  match '/monthly_invoice/new_layout' => 'monthly_invoice#new_layout', :as => :new_layout
  match '/monthly_invoice/custom_invoice' => 'monthly_invoice#custom_invoice', :as => :custom_invoice

  resources :chat, :only => [:index, :show] do
    collection do
      get 'venues'
    end
  end

  resources :remind_list, :only => [:create]
  resources :venues, :only => [:show] do
    member do
      post "subscribe"
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :payment_notifications

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :socialbutterflies
  resources :restaurants
  resources :companies
  resources :nonprofits
  resources :students
  resources :organizers

  scope "mobi" do
    resources :payments
  end

  resource :settings, :only => [:show, :update] do
    member do
      delete "credit_card"
      put "update_password"
      delete "facebook_connection"
      delete "twitter_connection"
    end
  end

  resource :newsletter, :only => [] do
    member do
      post "subscribe"
    end
  end
  resources :postcards, :only => [:create]

  match '/app' => 'app#index'
  match '/getVenue' => 'app#getVenue'
  match '/getVenues' => 'app#getVenues'
  match '/getCharities' => 'app#getCharities'
  match '/confirm' => 'app#confirm'
  match '/submit' => 'app#submit'
  match '/newinfo' => 'app#newinfo', :as => :user_info
  match '/create_voucher' => 'app#create_voucher'
  match '/voucher' => 'app#voucher'

  # API

  namespace :api do
    get "/weekly_meals" => "weekly_meals#show", as: "weekly_meals"

    post '/sessions/sign_in' => 'sessions#sign_in'
    post '/sessions/sign_up' => 'sessions#sign_up'

    put '/sessions/update' => 'sessions#update_profile'
    
    get '/news' => 'news#show'
    
    get '/venues/:lat/:lon' => 'venues#show', :constraints => { :lat => /[^\/]*/, :lon => /[^\/]*/ }
    get '/charities' => 'charities#show'
    
    get '/timeline' => 'timeline#show'
    post '/timeline/voucher/:id' => 'timeline#use_voucher'
    put '/timeline/verify_payment' => 'timeline#verify_payment_and_show_voucher'

    resource :payments, :only => [:create]

    scope 'general' do
      get '/users' => 'general#get_mailchimp_users'
    end
  end
  
  match '/mobi/reservation-login' => 'mobile#login'
  match '/mobi/reservation' => 'mobile#signup'
  match '/mobi/reservation_confirm' => 'mobile#callahead'
  match '/mobi/num_users' => 'mobile#num_users'
  match '/notification' => 'application#notification'

  # HighVoltage
  get '/faq/:id' => 'faq#show', :as => 'faq'
  get '/faq'     => 'faq#show', :as => 'faq', :id => 'faq'

  #Popups
  match '/postcard_popup' => 'popups#postcard', :as => :postcard_popup
  match '/notify_signup' => 'popups#notify_signup'
  match '/app_popup' => 'popups#app_popup'
  match '/:id' => 'home#index', :as => :venue_popup
  match '/deal_popup_not_logged/:id' => 'popups#deal_popup_not_logged'
  match '/reciept/:id' => 'popups#reciept'

  match '/download' => 'application#download', :as => :download

  match '/sms' => 'receive_texts#index', :via => :post

  match '/editor/:id' => 'editor#show'

  match '/race' => 'race#index'
  match '/cater' => 'home#cater', :as => :notgr
  match '/thanks' => 'home#thanks', :as => :notgr

  root :to => 'home#index'
end
