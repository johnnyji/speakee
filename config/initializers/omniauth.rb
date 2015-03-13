Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_key, Rails.application.secrets.facebook_secret,
            scope: "email, user_likes", display: "popup", image_size: { width: "50", height: "50"},
            info_fields: "first_name,last_name"
end