require "sinatra/base"
require "sinatra/namespace"
require "jwt"

require_relative './lib/virtualpet'
require_relative './config/config_database'


class App < Sinatra::Base
	register Sinatra::Namespace
	set :sessions => true

	set :session_secret, '1V[C1x`9p%k~L_5m*n@!Ma:/Jzs{)F~4u{I`}2o`CgjUr<!60)3\')GOJA+e1U5`' 

	helpers do
		def json_params
			begin
				JSON.parse(request.body.read)
			rescue
				halt 400, { message:'Invalid JSON' }.to_json
			end
		end

		def protected!
			return if authorized?
			redirect to('/')
		end

		def extract_token
			# check for the access_token header
			if request.env["HTTP_ACCESS_TOKEN"]
				return request.env["HTTP_ACCESS_TOKEN"]
			end

			# or check the session for the access_token
			token = session["access_token"]

			if token
				return token
			end
			return nil
		end

		def authorized?
			@token = extract_token
			puts @token
			begin
				payload, header = JWT.decode(@token, :session_secret.to_s, true, { algorithm: 'HS256' })
		
				@user_id = payload["user_id"]
				return true
			rescue JWT::DecodeError => e
				return false
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

		post '/login' do
			json = json_params
			username = json['username']
			password = json['password']

			# check the username and password
			if username == "username" && password == "password"
				@token = JWT.encode({user_id: 123456}, :session_secret.to_s, 'HS256')
				
				session["access_token"] = @token
				{'token' => @token}.to_json
			else
				@message = "Username/Password failed."
				erb:index
			end
		end


		get "/logout" do
			session["access_token"] = nil
		end

		get '/pets' do

		end

		get '/pet/:id' do |id|
			protected!
			pet = VirtualPet.new({'id' => id})
			# pet.update
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
				"tiredness" => pet.tiredness,
				"sleeping" => pet.sleeping,
				"weight" => pet.weight
			}.to_json
		end

		post '/pet' do
			protected!
			pet = VirtualPet.new({})
			{"id" => pet.id.to_s}.to_json
		end

		put '/pet/:id/feed' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.feed(value)
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
				"tiredness" => pet.tiredness,
				"sleeping" => pet.sleeping,
				"weigh" => pet.weight
			}.to_json
		end

		put '/pet/:id/cleen' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.cleen(value)
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
				"tiredness" => pet.tiredness,
				"sleeping" => pet.sleeping,
				"weigh" => pet.weight
			}.to_json
		end

		put '/pet/:id/play' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.play(value)
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
				"tiredness" => pet.tiredness,
				"sleeping" => pet.sleeping,
				"weigh" => pet.weight
			}.to_json
		end

		put '/pet/:id/heal' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.heal(value)
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
				"tiredness" => pet.tiredness,
				"sleeping" => pet.sleeping,
				"weigh" => pet.weight
			}.to_json
		end

		put '/pet/:id/sleep' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.sleep()
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
				"tiredness" => pet.tiredness,
				"sleeping" => pet.sleeping,
				"weigh" => pet.weight
			}.to_json
		end
	end
end
