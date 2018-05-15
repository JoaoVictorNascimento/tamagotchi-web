require_relative '../models/virtualpetmodel'

class VirtualPet
    attr_accessor :name, :happy, :health, :hunger,
                  :higiene, :birthday, :age, :state

    
	
	# TODO: change initialize
	def initialize(args)
        # name
        @name = args["name"] unless args["name"].nil?
        
        # happiness
        unless args["happy"].nil?
            @happy = args["happy"]
        else
            @happy = 100
        end

        # health
        unless args["health"].nil?
            @health = args["health"]
        else
            @health = 100
        end

        # hunger
        unless args["hunger"].nil?
            @hunger = args["hunger"]
        else
            @hunger = 100
        end

        # higiene
        unless args["higiene"].nil?
            @higiene = args["higiene"]
        else
            @higiene = 100
        end

        # birthday
        unless args["birthday"].nil?
            @birthday = args["birthday"]
        else
            @birthday = Time.now
        end

        # age
        unless args["age"].nil?
            @age = args["age"]
        else
            @age = 0
        end

        # state
        unless args["state"].nil?
            @state = args["state"]
        else
            @state = 0
        end
    end
end