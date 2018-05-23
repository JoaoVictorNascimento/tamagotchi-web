require "sinatra/base"
require "sinatra/namespace"
require "jwt"
require "bcrypt"

require_relative './lib/virtualpet'
require_relative './lib/minigames'
require_relative './config/config_database'
require_relative './models/usersmodel'
require_relative './models/virtualpetmodel'


class App < Sinatra::Base
	register Sinatra::Namespace
	set :sessions => true
	set :session_secret, '1V[C1x`9p%k~L_5m*n@!Ma:/Jzs{)F~4u{I`}2o`CgjUr<!60)3\')GOJA+e1U5`' 
	
	helpers do
		# get all params on requisition's body
		def json_params
			begin
				JSON.parse(request.body.read)
			rescue
				halt 400, { message:'Invalid JSON' }.to_json
			end
		end

		# user's need to be logged in
		def protected!
			return if authorized?
			redirect to('/')
		end

		# get user's auth token
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

		# check if user is auth
		def authorized?
			@token = extract_token
			begin
				payload, header = JWT.decode(@token, :session_secret.to_s, true, { algorithm: 'HS256' })
		
				@user_id = payload["user_id"]
				return true
			rescue JWT::DecodeError => e
				return false
			end
		end
	end
	
	# login page
	get '/' do
		@titulo = 'TAMAGOTCHI'
		erb :index
	end

	# menu page
	get '/menu' do
		protected!
		erb :menu 
	end 
	 
	# WHY??
	post '/menu' do
		protected!
		redirect '/menu' 
	end 
	 
	# main game page
	get '/tamagotchi' do
		protected!
		mg = MiniGames.new
		mg.jankenpo(1)
		erb :tamagotchi 
	end 
	 
	# create new pet
	get '/newpets' do
		protected! 
		erb :newpets 
	end 
	 
	# select an existent pet
	get '/mypets' do
		protected! 
		erb :mypets 
	end 
	 
	# ranking page
	get'/ranking' do
		protected! 
		erb :ranking 
	end 
	
	# singnup page
	get '/signup' do
		erb :signup
	end

	namespace '/api' do

		# USER ROUTES
		# BEGIN HERE

		# POST api/createuser to create a new user
		post '/createuser' do
			json = json_params
			username = json['username']
			password = json['password']
			password = BCrypt::Password.create(password)
			if UserModel.where("username" => username).first.nil?
				user = UserModel.create({"username" => username, "password" => password})
				user['_id'].to_json
			else
				halt 400, { message:'Usuario já cadastrado' }.to_json
			end
		end

		# POST api/login
		post '/login' do
			json = json_params
			username = json['username']
			password = json['password']

			user = UserModel.where({'username' => username}).first
			if user.nil?
				halt 400, { message:'User not exists' }.to_json
			end

			# check the password
			db_password = BCrypt::Password.new(user["password"].to_s)

			if db_password == password
				@token = JWT.encode({user_id: user['_id'].to_s}, :session_secret.to_s, 'HS256')
				
				session["access_token"] = @token
				{'token' => @token}.to_json
			else
				halt 400, { message:'Usuario ou senha incorreto' }.to_json
			end
		end

		# POST api/logout
		post "/logout" do
			session["access_token"] = nil
			redirect '/login'
		end
		# END HERE

		# PETS ROUTES
		# BEGIN HERE

		# GET api/pets
		get '/pets' do
			protected!
			VirtualPetModel.where({}).to_json
		end

		# GET api/userpets
		get '/userpets' do
			protected!
			VirtualPetModel.where({"user" => BSON::ObjectId(@user_id)}).to_json
		end

		# GET api/pet/:id
		get '/pet/:id' do |id|
			protected!
			pet = VirtualPet.new({'id' => id})
			pet.update
			{
				"name" => pet.name, 
				"user" => pet.user,
				"health" => pet.health, 
				"petType" => pet.petType,
				"stage" => pet.stage,
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

		# POST api/pet
		post '/pet' do
			protected!
			json = json_params
			creator = UserModel.where({"_id" => @user_id}).first["username"]
			pet = VirtualPet.new({"name" => json["name"], "user" => @user_id, "petType" => json["petType"], "creator" => creator})
			{"id" => pet.id.to_s}.to_json
		end

		# PUT api/pet/:id/name
		put '/pet/:id/name' do |id|
			protected!
			pet = VirtualPet.new('id' => id)
			pet.updateName(json_params['name'])
			{
				"name" => pet.name
			}.to_json
		end

		# PUT api/pet/:id/feed
		put '/pet/:id/feed' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.feed(value)
			{
				"name" => pet.name, 
				"user" => pet.user,
				"health" => pet.health, 
				"petType" => pet.petType,
				"stage" => pet.stage,
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

		# PUT api/pet/:id/clean		
		put '/pet/:id/clean' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.clean(value)
			{
				"name" => pet.name, 
				"user" => pet.user,
				"health" => pet.health, 
				"petType" => pet.petType,
				"stage" => pet.stage,
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

		# PUT api/pet/:id/play		
		put '/pet/:id/play' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.play(value)
			{
				"name" => pet.name, 
				"user" => pet.user,
				"health" => pet.health, 
				"petType" => pet.petType,
				"stage" => pet.stage,
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

		# PUT api/pet/:id/heal		
		put '/pet/:id/heal' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.heal(value)
			{
				"name" => pet.name, 
				"user" => pet.user,
				"health" => pet.health, 
				"petType" => pet.petType,
				"stage" => pet.stage,
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

		# PUT api/pet/:id/sleep		
		put '/pet/:id/sleep' do |id|
			protected!
			value = json_params['value']
			pet = VirtualPet.new({'id' => id})
			pet.sleep()
			{
				"name" => pet.name, 
				"user" => pet.user,
				"health" => pet.health, 
				"petType" => pet.petType,
				"stage" => pet.stage,
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
		# END HERE

		# MINIGAME ROUTES
		# BEGIN HERE

		# api/minigame/jankenpo
		post '/minigame/jankenpo' do
			protected!
			minigame = MiniGames.new
			minigame.jankenpo(json_params['jankenpo']).to_json
		end
		# END HERE
	end
end
