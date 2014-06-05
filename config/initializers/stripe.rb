stripe_publishable_key =  ENV["STRIPE_PUBLIC_KEY"]
stripe_secret_key = ENV["STRIPE_API_KEY"]
Rails.configuration.stripe = {

    :publishable_key => stripe_publishable_key,
    :secret_key      => stripe_secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
