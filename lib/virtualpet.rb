class VirtualPet
    def initalize(name)
        @name = name
        @happy = 100
        @health = 100
        @hunger = 100
        @higiene = 100
        @birthday = Time.now
        @age
        @state = "normal"
    end

    def get_name() 
        puts @name
    end

    def get_happy()
        puts @idade
    end

    def get_health()
        puts @health
    end

    def get_hunger()
        puts @hunger
    end

    def get_higiene()
        puts @higiene
    end

    def get_birthday()
        puts @birthday
    end

    def get_age()
        puts @age
    end
    
    def get_state()
        puts @state
    end

    def set_state()
        @state = state
    end

    def set_name() 
        @name = name
    end

    def set_happy()
        @idade = name
    end

    def set_health()
        @health = name
    end

    def set_hunger()
        @hunger = name
    end

    def set_higiene()
        @higiene = name
    end

end