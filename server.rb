require "sinatra/base"
require "sinatra/namespace"

require_relative './lib/virtualpet'
require_relative './config/config_database'


class App < Sinatra::Base
	register Sinatra::Namespace

	helpers do
		def json_params
		  begin
			JSON.parse(request.body.read)
		  rescue
			halt 400, { message:'Invalid JSON' }.to_json
		  end
		end
	end
	

	get '/' do
		@titulo = 'TAMAGOTCHI'
		erb:index
	end
	
	get '/signup' do
		erb :signup
	end

	namespace '/api' do

		get '/pets' do

		end

		get '/pet/:id' do |id|
			pet = VirtualPet.new({'id' => id})
			{
				"name" => pet.name, 
				"health" => pet.health, 
				"petType" => pet.petType,
				"happy" => pet.happy,
				"hunger" => pet.hunger,
				"higiene" => pet.higiene,
				"birthday" => pet.birthday,
				"age" => pet.age,
				"state" => pet.state,
				"weight" => pet.weight
			}.to_json
		end

		get '/pet/:id/update' do |id|
			pet = VirtualPet.new({'id' => id})
			pet.update
			{
				"name" => pet.name, 
				"health" => pet.health, 
				"petType" => pet.petType,
				"happy" => pet.happy,
				"hunger" => pet.hunger,
				"higiene" => pet.higiene,
				"birthday" => pet.birthday,
				"age" => pet.age,
				"state" => pet.state,
				"weight" => pet.weight
			}.to_json
		end

		post '/pet' do
			pet = VirtualPet.new({})
			{"id" => pet.id.to_s}.to_json
		end
	end
end
