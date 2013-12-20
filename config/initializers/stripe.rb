stripe_publishable_key =  'pk_live_REo0N70jby0jLnBJtkxLidIY'
stripe_secret_key = 'sk_live_u41ebuHziVeZbpgmIeAhqb9A'
#PUBLISHABLE_KEY =  'pk_test_lx08ICojucE57BHxppeWEBV0'
#SECRET_KEY = 'sk_test_EEbbjQT23ZpQcmZIlu4BTEBi'
Rails.configuration.stripe = {

    :publishable_key => stripe_publishable_key,
    :secret_key      => stripe_secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
