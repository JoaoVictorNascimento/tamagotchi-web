require "sinatra/base"
require "sinatra/namespace"

require_relative './lib/virtualpet'
require_relative './config/config_database'


class App < Sinatra::Base
	register Sinatra::Namespace

	get '/' do
		@titulo = 'TAMAGOTCHI'
		tm = VirtualPet.new('rakeup')
		erb:index
	end
	
	get '/signup' do
		erb :signup
	end

	namespace '/api' do
		get '/' do
			'teste'
		end
	end
end
