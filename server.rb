require 'sinatra'
require_relative './lib/virtualpet'

set :port, 8080

get '/' do
  @titulo = 'TAMAGOTCHI'
  erb:index
end

get '/signup' do
  erb :signup
end
