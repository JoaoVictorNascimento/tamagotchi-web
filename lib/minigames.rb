module JankenpoOp
    ROCK = 0
    PAPER = 1
    SCISSOR = 2
end

module GameStatus
    TIE = 0
    WIN = 1
    LOSE = -1
    INVALID = -2
end

class MiniGames
    def jankenpo(player)
        rand = Random.new
        enemy = rand.rand(3)
 
        if player == JankenpoOp::ROCK
            if enemy == JankenpoOp::ROCK
                return GameStatus::TIE
            elsif enemy == JankenpoOp::PAPER
                return GameStatus::LOSE
            elsif enemy == JankenpoOp::SCISSOR
                return GameStatus::WIN                
            end
        elsif player == JankenpoOp::SCISSOR
            if enemy == JankenpoOp::ROCK
                return GameStatus::LOSE
            elsif enemy == JankenpoOp::PAPER
                return GameStatus::WIN
            elsif enemy == JankenpoOp::SCISSOR
                return GameStatus::TIE
            end
        elsif player == JankenpoOp::PAPER
            if enemy == JankenpoOp::ROCK
                return GameStatus::WIN
            elsif enemy == JankenpoOp::PAPER
                return GameStatus::TIE
            elsif enemy == JankenpoOp::SCISSOR
                return GameStatus::LOSE
            end
        else
            return GameStatus::INVALID
        end
    end

    def coin(side)
        rand = Random.new
        fate = rand.rand(2)
        if fate == side
            return GameStatus::WIN
        else
            return GameStatus::LOSE
        end
    end

    def battle(pokemon, enemy, attack)
        rand = Random.new
        if pokemon.stage == 'v1'
            attackRate = 1.3
            enemyAtackRate = 1.6
        elsif pokemon.stage == 'v2'
            attackRate = 1.7
            enemyAtackRate = 1.5
        else
            attackRate = 2
            enemyAtackRate = 1.4
        end

        if attack == 0 # normal attack
            damage = rand.rand(5..15)
            enemy -= damage * attackRate
        else
            miss = rand.rand(0..3)
            if miss != 0
                damage = rand.rand(20..30)
                enemy -= damage * attackRate
            end
        end

        enemyDamage = rand.rand(5..60)
        miss = rand.rand(0..3)
        if miss != 0
            pokemon.health -= (damage * enemyAtackRate)
            pokemon.save()
        end

        return enemy

    end
end