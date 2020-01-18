# Dictionary containing words that indicate game-over in Ghost game.

require "set"

def create_dictionary
    file = File.open("ghost_dictionary.txt")
    dictionary = Set.new

    file.readlines.each do |line|
        dictionary.add(line.chomp)
    end

    file.close

    return dictionary

end

#p create_dictionary

