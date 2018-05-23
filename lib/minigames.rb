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
end