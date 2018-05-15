require 'mongoid'

# DB Setup
Mongoid.load!("./config/mongoid.yml", :development)