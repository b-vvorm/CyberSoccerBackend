# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_CyberSoccerBackend_session',
  :secret      => 'e5353e698cfd28703a1b7e6cec7dd530ceb3634010884118f55cc677ed8e0c5666d7fd37bc96b7db09e58808955689ddbfed88edaee75a815552413b0446e8d2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
