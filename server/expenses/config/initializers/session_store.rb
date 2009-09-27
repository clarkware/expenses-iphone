# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_expenses_session',
  :secret      => '89fa065999e636dcc6f9cd9345cc1fbd693503bb14bb8ccdd13b8507d2b71092ed6ed5a90f921ffb8cfec9084719850d822d6da1a8b2498424f188f67ba65032'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
