Rails.configuration.stripe = {
  :publishable_key => 'pk_test_yBVcFyDWFZeqbpVo6fKuLzUf',
  :secret_key      => 'sk_test_bF0tZeM2m2DHj6prtQ6nni7G'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
