# Player class that includes information about players in Ghost game.
# Created by Armando Ortiz, concept from Open App Academy

class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def guess
        puts "\nPlease enter your guess of which letter comes next, " + self.name.to_s + "."
        gets.chomp
    end

    def alert_invalid_guess
        puts "\nThat is an invalid guess. Try again."
    end
end