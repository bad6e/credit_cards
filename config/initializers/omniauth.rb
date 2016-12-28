Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'],
           scope: 'public_profile, email', info_fields: 'id,name,email,link'
  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']

  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:auth_failure).call(env)
  end
end