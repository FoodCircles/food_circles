Foodcircles::Application.routes.draw do

  get "socialbutterflies/index"

  # match '/offers' => 'offers#index', :as => :offers
  resources :offers
  resources :categories
  match '/companies' => 'companies#index', :as => :companies
  match '/nonprofits' => 'nonprofits#index', :as => :nonprofits
  match '/restaurants' => 'restaurants#index', :as => :restaurants
  match '/butterflies' => 'socialbutterflies#index', :as => :socialbutterflies
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
  resources :venues, :only => [:show]
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :payment_notifications

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :socialbutterflies
  resources :restaurants
  resources :companies
  resources :nonprofits

  match '/app' => 'app#index'
  match '/getVenue' => 'app#getVenue'
  match '/getVenues' => 'app#getVenues'
  match '/getCharities' => 'app#getCharities'
  match '/confirm' => 'app#confirm'
  match '/submit' => 'app#submit'
  match '/newinfo' => 'app#newinfo', :as => :user_info
  match '/create_voucher' => 'app#create_voucher'
  match '/voucher' => 'app#voucher'


  match '/api/venues/:id' => 'venues#show'
  match '/api/venues' => 'venues#index'
  match '/api/offers/:id' => 'offers#show'
  match '/api/charities/:id' => 'charities#show'
  match '/api/notification' => 'mobile#notification'
  match '/mobi/reservation-login' => 'mobile#login'
  match '/mobi/reservation' => 'mobile#signup'
  match '/mobi/reservation_confirm' => 'mobile#callahead'
  match '/mobi/num_users' => 'mobile#num_users'
  match '/notification' => 'application#notification'


  match '/auth/:provider/callback', :to => 'sessions#create', as: 'callback'

  match '/download' => 'application#download', :as => :download

  match '/sms' => 'receive_texts#index', :via => :post

  match '/editor/:id' => 'editor#show'

  match '/race' => 'race#index'
  match '/cater' => 'home#cater', :as => :notgr
  match '/thanks' => 'home#thanks', :as => :notgr
  
  #HighVoltage
  get '/faq/:id' => 'faq#show', :as => 'faq'
  get '/faq'     => 'faq#show', :as => 'faq', :id => 'faq'

  root :to => 'home#index'
end
