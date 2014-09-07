#!/Users/Brigid/.rvm/rubies/ruby-2.1.2/bin/ruby

# My Dungeon class
require "./Dungeon.rb"

###################################
### Main code here
###################################

# Ask for the player's name
print "Name of player: "
player_name = gets.chomp

# Create a dungeon object for this player
my_dungeon = Dungeon.new(player_name)
puts "Hello #{my_dungeon.player.name}!"
puts "I'm starting up the dungeon for you..."
puts "If you would like to exit, just type 'quit'"
# puts "*" * 80

# Generate some rooms
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {:east => :largecave})
my_dungeon.add_room(:largecave, "Large Cave", "a large, cavernous cave", {:west => :smallcave, :north => :fancyroom})
my_dungeon.add_room(:fancyroom, "Fancy Room", "a room with very fancy wall decor and treasure chests", {:south => :largecave})
# puts "*" * 80

# Add some monsters?
my_dungeon.add_monster("Orc", :fancyroom)


# Start the dungeon, I'm putting the player in the Large Cave for now
my_dungeon.start(:largecave)
# puts "*" * 80

# Ask the player which direction they would like to move in
# Allow them to say "quit" in order to quit
player_input = ""
monster_counter = 0
until player_input.downcase == "quit"

  # Maybe there should be a function here that asks for player input
  # based on the current state of the room?
  # my_dungeon.ask_for_input(current_location), perhaps?

  puts "What direction would you like to go?"
  player_input = gets.chomp.downcase

  if player_input != "quit"
    # check to see if it's a possible direction
    if my_dungeon.can_go?(player_input)
      my_dungeon.go(player_input.to_sym)
      # After a certain number of moves, initialize a monster somewhere!
      monster_counter += 1

      if monster_counter % 5 == 0
        puts "Another monster appears somewhere in the dungeon!"
        # Create a monster in a random room
        # get a list of rooms
        roomarray = my_dungeon.get_room_list
        # choose a random one
        randroom = roomarray[rand(roomarray.length)]
        # add a monster to it
        my_dungeon.add_monster("Orc", randroom)

      end
    else
      puts "You can't go that way from here, try again!"
    end
  end
end
