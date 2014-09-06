class Dungeon
  attr_accessor :player

  # Use the Struct class for Player and Room for now
  # I commented out the original code below
  # Player = Struct.new(:name, :location)
  # Room = Struct.new(:reference, :name, :description, :connections)

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
    @monsters = []
  end

  def add_monster(type, location)
    @monsters << Monster.new(type, location)
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def find_monster_in_dungeon(reference)
    @monsters.detect { |monster| monster.location == reference }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def can_go?(direction)
    # gets a list of the ways you can exit a room
    poss_direction = find_room_in_dungeon(@player.location).connections.keys
    poss_direction.include? direction.to_sym
  end

  def go(direction)
    puts "You go #{direction.to_s}"
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end

  class Monster
    attr_accessor :type, :location

    def initialize(type, location)
      @type = type
      @location = location
    end

    def move_to(reference)
      @location = reference
    end

  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      puts "#{@name}"
      puts "You are in #{@description}"
      if @monsters.length > 0
        puts "Monsters!!! The following monsters are in here:"
        #puts @monsters.each {}
      end
      puts "You see exits in the following directions:"
      puts @connections.keys.each {|n| n}


      # if monster_in_room?(@reference)
      #   puts "There is a monster in here!"
      # end
    end

  end
end
