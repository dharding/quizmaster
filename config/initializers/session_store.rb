# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_quizmaster_session',
  :secret      => '3b05424fe57d95d39d373533745f696f7cd1bc939ab6f0b490b7567987c314e237e69db886832d2d03e869ae289db77c1148d1c3db7d9c5cd26217204efcdc1f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
