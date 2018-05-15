require 'sinatra'
require_relative './lib/virtualpet'

set :port, 8080

get '/teste' do
  "Hello World"
end