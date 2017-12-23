Rails.configuration.stripe = {
  :publishable_key => 'pk_live_FrC0EBrB461hkOFY4YH1IsIl',
  :secret_key      => 'sk_live_DjN36Gen8Qo3ODO3se9EtOGO'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
