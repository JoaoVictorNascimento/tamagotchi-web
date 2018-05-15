require "sinatra"

set :port, 8080

get '/' do
  @titulo = 'TAMAGOTCHI'
  erb:index
end

get '/signup' do
  erb :signup
end
