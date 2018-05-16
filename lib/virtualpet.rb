require_relative '../models/virtualpetmodel'

class VirtualPet
	attr_accessor :id, :name, :petType, :happy, :health, :hunger,
				  :higiene, :birthday, :age, :state, :weight, :lastTime
	
	# TODO: change initialize
	def initialize(args)
		unless args['id'].nil?
			pet = VirtualPetModel.where({'_id': BSON::ObjectId(args['id'])}).first
			@name = pet['name'].to_s
			@petType = pet['petType'].to_s
			@happy = pet['happy'].to_i
			@health = pet['health'].to_i
			@hunger = pet['hunger'].to_i
			@higiene = pet['higiene'].to_i
			@birthday = pet['birthday'].to_s
			@age = pet['age'].to_i
			@state = pet['state'].to_s
			@weight = pet['weight'].to_i
			@lastTime = pet['lastTime'].to_s
			@id = pet['_id'].to_s
		else
			# if ID is not pass... create a new pet
			newPet = Hash.new

			unless args['name'].nil?
				@name = args['name']
			else
				@name = 'pet'
			end
			newPet['name'] = @name

			unless args['petType'].nil?
				@petType = args['petType']
			else
				@petType = 1
			end
			newPet['petType'] = @petType

			unless args['happy'].nil?
				@happy = args['happy']
			else
				@happy = 100
			end
			newPet['happy'] = @happy

			unless args['health'].nil?
				@health = args['health']
			else
				@health = 100
			end
			newPet['health'] = @health

			unless args['hunger'].nil?
				@hunger = args['hunger']
			else
				@hunger = 100
			end
			newPet['hunger'] = @hunger

			unless args['higiene'].nil?
				@higiene = args['higiene']
			else
				@higiene = 100
			end
			newPet['higiene'] = @higiene

			unless args['birthday'].nil?
				@birthday = args['birthday']
			else
				@birthday = Time.now
			end
			newPet['birthday'] = @birthday

			unless args['age'].nil?
				@age = args['age']
			else
				@age = 0
			end
			newPet['age'] = @age

			unless args['state'].nil?
				@state = args['state']
			else
				@state = 'normal'
			end
			newPet['state'] = @state

			unless args['weight'].nil?
				@weight = args['weight']
			else
				@weight = 50
			end
			newPet['weight'] = @weight

			@lastTime = Time.now  
			newPet['lastTime'] = @lastTime.to_datetime
			@id = VirtualPetModel.create(newPet)['_id']
		end
	end

	def update()
		randStatus = Random.new
		updatePet = Hash.new
		time = Time.now
		deltaTime = time - @lastTime.to_datetime

		updatePet['lastTime'] = @lastTime = time.to_datetime

		if @state == 'normal'
			healthRate = 1;	happyRate = 1
			hungerRate = 1
			higieneRate = 1

			valor = 0
			valor = @health - ((healthRate * randStatus.rand(0..0.03)) * deltaTime).to_i
			updatePet['health'] = @health = (valor > 0) ? valor : 0
			
			valor = @happy - ((happyRate * randStatus.rand(0..0.05)) * deltaTime).to_i
			updatePet['happy'] = @happy = (valor > 0) ? valor : 0
			
			valor = @hunger - ((hungerRate * randStatus.rand(0.002..0.05)) * deltaTime).to_i
			updatePet['hunger'] = @hunger = (valor > 0) ? valor : 0
			
			valor = @higiene - ((higieneRate * randStatus.rand(0.002..0.05)) * deltaTime).to_i
			updatePet['higiene'] = @higiene = (valor > 0) ? valor : 0
		end

		VirtualPetModel.where({'_id': @id}).first.update(updatePet)
	end
end