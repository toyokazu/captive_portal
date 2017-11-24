Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           scope: 'email,public_profile'
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],
           scope: "https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/plus.login"
  provider :identity,
           on_login: IdentitiesController.action(:login),
           on_registration: IdentitiesController.action(:new),
           on_failed_registration: IdentitiesController.action(:new)
end
