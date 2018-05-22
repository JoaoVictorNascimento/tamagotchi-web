require 'date'
require_relative '../models/virtualpetmodel'

class VirtualPet
	attr_accessor :id, :name, :petType, :happy, :health, :hunger, :tiredness, :user, :creator,
				  :higiene, :birthday, :age, :state, :weight, :lastTime, :sleeping
	
	def initialize(args)
		unless args['id'].nil?
			pet = VirtualPetModel.where({'_id': BSON::ObjectId(args['id'])}).first
			@name = pet['name'].to_s
			@user = pet['user'].to_s
			@creator = pet['creator'].to_s
			@petType = pet['petType'].to_s
			@happy = pet['happy'].to_f
			@health = pet['health'].to_f
			@tiredness = pet['tiredness'].to_f
			@hunger = pet['hunger'].to_f
			@higiene = pet['higiene'].to_f
			@birthday = pet['birthday'].to_s
			@age = pet['age'].to_f
			@state = pet['state'].to_s
			@weight = pet['weight'].to_f
			@lastTime = pet['lastTime'].to_s
			@sleeping = pet['sleeping'].to_s
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

			unless args['user'].nil?
				@user = args['user']
			else
				@user = nil
			end
			newPet['user'] = @user

			unless args['creator'].nil?
				@creator = args['creator']
			else
				@creator = nil
			end
			newPet['creator'] = @creator

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

			unless args['tiredness'].nil?
				@tiredness = args['tiredness']
			else
				@tiredness = 100
			end
			newPet['tiredness'] = @tiredness

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

			unless args['sleeping'].nil?
				@sleeping = args['sleeping']
			else
				@sleeping = 'false'
			end
			newPet['sleeping'] = @sleeping

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

	def checkState()
		if @state == 'normal'
			if @health == 0 && @hunger == 0 && @higiene == 0 && @happy == 0 && @tiredness == 0
				@state = 'dead'
			elsif @health < 30
				@state = 'sick'
			elsif @hunger < 40
				@state = 'hunger'
			elsif @tiredness < 30
				@state = 'tired'
			elsif @higiene < 50
				@state = 'dirty'
			elsif @happy < 50
				@state = 'sad' 
			end
		# end normal

		elsif @state == 'sick'
			if @health == 0 && @hunger == 0 && @higiene == 0 && @happy == 0
				@state = 'dead'
			elsif @health < 60
				@state = 'sick'
			elsif @hunger < 50
				@state = 'hunger'
			elsif @tiredness < 50
				@state = 'tired'
			elsif @higiene < 60
				@state = 'dirty'
			elsif @happy < 60
				@state = 'sad' 
			else
				@state = 'normal'
			end
		# end sick

		elsif @state == 'sad'
			if @health == 0 && @hunger == 0 && @higiene == 0 && @happy == 0
				@state = 'dead'
			elsif @health < 40
				@state = 'sick'
			elsif @tiredness < 40
				@state = 'tired'
			elsif @hunger < 30
				@state = 'hunger'
			elsif @higiene < 50
				@state = 'dirty'
			elsif @happy < 70
				@state = 'sad' 
			else
				@state = 'normal'
			end
		#end sad

		elsif @state == 'dirty'
			if @health == 0 && @hunger == 0 && @higiene == 0 && @happy == 0
				@state = 'dead'
			elsif @health < 50
				@state = 'sick'
			elsif @tiredness < 30
				@state = 'tired'
			elsif @hunger < 40
				@state = 'hunger'
			elsif @higiene < 60
				@state = 'dirty'
			elsif @happy < 60
				@state = 'sad' 
			else
				@state = 'normal'
			end
		# end dirty

		elsif @state == 'hunger'
			if @health == 0 && @hunger == 0 && @higiene == 0 && @happy == 0
				@state = 'dead'
			elsif @health < 40
				@state = 'sick'
			elsif @tiredness < 30
				@state = 'tired'
			elsif @hunger < 60
				@state = 'hunger'
			elsif @higiene < 50
				@state = 'dirty'
			elsif @happy < 60
				@state = 'sad' 
			else
				@state = 'normal'
			end

		elsif @state == 'tired'
			if @health == 0 && @hunger == 0 && @higiene == 0 && @happy == 0 && @tiredness == 0
				@state = 'dead'
			elsif @health < 30
				@state = 'sick'
			elsif @hunger < 40
				@state = 'hunger'
			elsif @tiredness < 50
				@state = 'tired'
			elsif @higiene < 50
				@state = 'dirty'
			elsif @happy < 50
				@state = 'sad' 
			end
		end
	end


	def update()
		randStatus = Random.new
		updatePet = Hash.new
		time = Time.now
		deltaTime = time - @lastTime.to_datetime
		# puts deltaTime

		updatePet['lastTime'] = @lastTime = time.to_datetime

		if @state == 'normal'
			healthRate = 1
			happyRate = 1
			hungerRate = 2
			higieneRate = 1
			tirednessDownRate = 1
			tirednessUpRate = 2

			value = 0
			value = @health - ((healthRate * randStatus.rand(0..0.0004)) * deltaTime).to_f
			updatePet['health'] = @health = (value > 0) ? value : 0
			
			value = @happy - ((happyRate * randStatus.rand(0.0002..0.0008)) * deltaTime).to_f
			updatePet['happy'] = @happy = (value > 0) ? value : 0
			
			value = @hunger - ((hungerRate * randStatus.rand(0.0003..0.0006)) * deltaTime).to_f
			updatePet['hunger'] = @hunger = (value > 0) ? value : 0
			
			value = @higiene - ((higieneRate * randStatus.rand(0.0001..0.0009)) * deltaTime).to_f
			updatePet['higiene'] = @higiene = (value > 0) ? value : 0

			if @sleeping == 'true' || @sleeping == true
				value = @tiredness + ((tirednessUpRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value < 100) ? value : 100
				if @tiredness == 100
					updatePet['sleeping'] = @sleeping = false
				end
			else
				value = @tiredness - ((tirednessDownRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value > 0) ? value : 0
			end


		# end normal

		elsif @state == 'sick'
			healthRate = 4
			happyRate = 3
			hungerRate = 3
			higieneRate = 3
			tirednessDownRate = 2
			tirednessUpRate = 1

			value = 0
			value = @health - ((healthRate * randStatus.rand(0..0.0004)) * deltaTime).to_f
			updatePet['health'] = @health = (value > 0) ? value : 0
			
			value = @happy - ((happyRate * randStatus.rand(0.0002..0.0008)) * deltaTime).to_f
			updatePet['happy'] = @happy = (value > 0) ? value : 0
			
			value = @hunger - ((hungerRate * randStatus.rand(0.0003..0.0006)) * deltaTime).to_f
			updatePet['hunger'] = @hunger = (value > 0) ? value : 0
			
			value = @higiene - ((higieneRate * randStatus.rand(0.0001..0.0009)) * deltaTime).to_f
			updatePet['higiene'] = @higiene = (value > 0) ? value : 0

			if @sleeping == 'true' || @sleeping == true
				value = @tiredness + ((tirednessUpRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value < 100) ? value : 100
				if @tiredness == 100
					updatePet['sleeping'] = @sleeping = false
				end
			else
				value = @tiredness - ((tirednessDownRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value > 0) ? value : 0
			end
		# end sick

		elsif @state == 'sad'
			healthRate = 2
			happyRate = 4
			hungerRate = 1
			higieneRate = 2
			tirednessDownRate = 1
			tirednessUpRate = 1

			value = 0
			value = @health - ((healthRate * randStatus.rand(0..0.0003)) * deltaTime).to_f
			updatePet['health'] = @health = (value > 0) ? value : 0
			
			value = @happy - ((happyRate * randStatus.rand(0..0.0005)) * deltaTime).to_f
			updatePet['happy'] = @happy = (value > 0) ? value : 0
			
			value = @hunger - ((hungerRate * randStatus.rand(0.0002..0.0005)) * deltaTime).to_f
			updatePet['hunger'] = @hunger = (value > 0) ? value : 0
			
			value = @higiene - ((higieneRate * randStatus.rand(0.0002..0.0005)) * deltaTime).to_f
			updatePet['higiene'] = @higiene = (value > 0) ? value : 0

			if @sleeping == 'true' || @sleeping == true
				value = @tiredness + ((tirednessUpRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value < 100) ? value : 100
				if @tiredness == 100
					updatePet['sleeping'] = @sleeping = false
				end
			else
				value = @tiredness - ((tirednessDownRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value > 0) ? value : 0
			end
		#end sad

		elsif @state == 'dirty'
			healthRate = 3
			happyRate = 2
			hungerRate = 0.5
			higieneRate = 4
			tirednessDownRate = 1
			tirednessUpRate = 2

			value = 0
			value = @health - ((healthRate * randStatus.rand(0..0.0003)) * deltaTime).to_f
			updatePet['health'] = @health = (value > 0) ? value : 0
			
			value = @happy - ((happyRate * randStatus.rand(0..0.0005)) * deltaTime).to_f
			updatePet['happy'] = @happy = (value > 0) ? value : 0
			
			value = @hunger - ((hungerRate * randStatus.rand(0.0002..0.0005)) * deltaTime).to_f
			updatePet['hunger'] = @hunger = (value > 0) ? value : 0
			
			value = @higiene - ((higieneRate * randStatus.rand(0.0002..0.0005)) * deltaTime).to_f
			updatePet['higiene'] = @higiene = (value > 0) ? value : 0

			if @sleeping == 'true' || @sleeping == true
				value = @tiredness + ((tirednessUpRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value < 100) ? value : 100
				if @tiredness == 100
					updatePet['sleeping'] = @sleeping = false
				end
			else
				value = @tiredness - ((tirednessDownRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value > 0) ? value : 0
			end
		# end dirty

		elsif @state == 'hunger'
			healthRate = 3
			happyRate = 2
			hungerRate = 3
			higieneRate = 1
			tirednessDownRate = 1
			tirednessUpRate = 1

			value = 0
			value = @health - ((healthRate * randStatus.rand(0..0.0003)) * deltaTime)
			updatePet['health'] = @health = (value > 0) ? value : 0
			
			value = @happy - ((happyRate * randStatus.rand(0..0.0005)) * deltaTime).to_f
			updatePet['happy'] = @happy = (value > 0) ? value : 0
			
			value = @hunger - ((hungerRate * randStatus.rand(0.0002..0.0005)) * deltaTime)
			updatePet['hunger'] = @hunger = (value > 0) ? value : 0
			
			value = @higiene - ((higieneRate * randStatus.rand(0.0002..0.0005)) * deltaTime)
			updatePet['higiene'] = @higiene = (value > 0) ? value : 0

			if @sleeping == 'true' || @sleeping == true
				value = @tiredness + ((tirednessUpRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value < 100) ? value : 100
				if @tiredness == 100
					updatePet['sleeping'] = @sleeping = false
				end
			else
				value = @tiredness - ((tirednessDownRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value > 0) ? value : 0
			end

		elsif @state == 'tired'
			healthRate = 2
			happyRate = 1
			hungerRate = 3
			higieneRate = 2
			tirednessDownRate = 3
			tirednessUpRate = 1

			value = 0
			value = @health - ((healthRate * randStatus.rand(0..0.0003)) * deltaTime)
			updatePet['health'] = @health = (value > 0) ? value : 0
			
			value = @happy - ((happyRate * randStatus.rand(0..0.0005)) * deltaTime).to_f
			updatePet['happy'] = @happy = (value > 0) ? value : 0
			
			value = @hunger - ((hungerRate * randStatus.rand(0.0002..0.0005)) * deltaTime)
			updatePet['hunger'] = @hunger = (value > 0) ? value : 0
			
			value = @higiene - ((higieneRate * randStatus.rand(0.0002..0.0005)) * deltaTime)
			updatePet['higiene'] = @higiene = (value > 0) ? value : 0

			if @sleeping == 'true' || @sleeping == true
				value = @tiredness + ((tirednessUpRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value < 100) ? value : 100
				if @tiredness == 100
					updatePet['sleeping'] = @sleeping = false
				end
			else
				value = @tiredness - ((tirednessDownRate * randStatus.rand(0.00009..0.0015)) * deltaTime).to_f
				updatePet['tiredness'] = @tiredness = (value > 0) ? value : 0
			end
		end
		@age = days_between = (Date.parse(Time.now.to_s) - Date.parse(@birthday.to_s)).round
		updatePet['age'] = @age
		checkState()
		updatePet['state'] = @state
		VirtualPetModel.where({'_id': @id}).first.update(updatePet)
	end

	def feed(value)
		unless @sleeping
			updatePet = Hash.new
			value = @hunger + value
			updatePet['hunger'] = @hunger = (value < 100) ? value : 100
			value = @weight + value/100.0
			updatePet['weight'] = @weight = (value < 100) ? value : 100
			checkState()
			update['state'] = @state
			VirtualPetModel.where({'_id': @id}).first.update(updatePet)
		end
	end

	def cleen(value)
		unless @sleeping
			updatePet = Hash.new
			value = @higiene + value
			updatePet['higiene'] = @higiene = (value < 100) ? value : 100
			value = @health + value/4
			updatePet['health'] = @health = (value < 100) ? value : 100
			checkState()
			update['state'] = @state
			VirtualPetModel.where({'_id': @id}).first.update(updatePet)
		end
	end

	def play(value)
		unless @sleeping
			updatePet = Hash.new
			value = @happy + value
			updatePet['happy'] = @happy = (value < 100) ? value : 100
			value = @health + value/4
			updatePet['health'] = @health = (value < 100) ? value : 100
			value = @weight - value/100
			updatePet['weight'] = @weight = (value < 100) ? value : 100
			checkState()
			update['state'] = @state
			VirtualPetModel.where({'_id': @id}).first.update(updatePet)
		end
	end

	def heal(value)
		unless @sleeping
			updatePet = Hash.new
			value = @health + value
			updatePet['health'] = @health = (value < 100) ? value : 100
			value = @happy + value/4
			updatePet['happy'] = @happy = (value < 100) ? value : 100
			checkState()
			update['state'] = @state
			VirtualPetModel.where({'_id': @id}).first.update(updatePet)
		end
	end

	def sleep()
		@sleeping = !@sleeping
		VirtualPetModel.where({'_id': @id}).first.update({"sleeping" => @sleeping})
	end
end