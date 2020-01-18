# Class that contains the game information for Ghost game.
# Created by Armando Ortiz, concept from Open App Academy

require_relative "./player.rb"
require_relative "./dictionary.rb"

class Game
    attr_reader :players, :current_player, :previous_player

    GHOST = "GHOST"

    def initialize(player1_name, *other_players)
        @players = [Player.new(player1_name)]
        other_players.each {|player_name| @players << Player.new(player_name)}

        @current_player = @players[0]
        @previous_player = nil

        @fragment = ""

        @dictionary = create_dictionary

        @losses = Hash.new(0)
    end

    def next_player!
        @previous_player = @current_player

        curr_i = @players.index(@current_player)
        @current_player = @players[(curr_i + 1) % @players.length]
    end

    def valid_play?(string)
        valid_chars = "abcdefghijklmnopqrstuvwxyz"

        #Checking to see if adding to fragment would build up to a valid word
        valid_fragment = false
        @dictionary.each do |word|
            valid_fragment = true if word[0...(@fragment + string).length] == (@fragment + string)
        end

        string.split.all?{|char| valid_chars.include?(char)}  && valid_fragment
    end

    def take_turn(player)
        valid = false
        input = ""

        
        input = player.guess
        if valid_play?(input)
            valid = true
            @fragment += input
        else
            player.alert_invalid_guess
                
        end

    end

    def lost_point(player)
        @losses[player] += 1
    end

    def write_word(player)
        GHOST[0...@losses[player]]
    end

    def lost_round(player)
        current = write_word(player)
        puts "\nOh no, " + player.name + "! You've earned letter " + current[current.length-1] + "."
        puts "Your word: " + current + "." + "\n"

        if current == GHOST
            puts "Sorry " + player.name + ", you're out!" + "\n"
            @players.delete(player)
        else
            puts "You have " + (GHOST.length - @losses[player]).to_s + " lives left." + "\n" 
        end

        current
    end

    def display_scores
        puts "\nScores:"

        @players.each do |player|
            puts player.name + ": " + write_word(player)
        end
    end

    def play_round
        self.display_scores
        while !@dictionary.include?(@fragment)
            take_turn(@current_player)
            self.next_player!    
        end

        lost_point(@previous_player)
        lost_round(@previous_player)
        @fragment = ""
    end

    def run 
        while @players.length > 1
            play_round
        end
    end

end

game = Game.new("Armando", "Gely")

game.run


