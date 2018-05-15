require "sinatra/base"

require_relative './lib/virtualpet'
require_relative './config/config_database'


class App < Sinatra::Base
  get '/' do
    @titulo = 'TAMAGOTCHI'
    tm = VirtualPet.new('rakeup')
    erb:index
  end
  
  get '/signup' do
    erb :signup
  end
end
