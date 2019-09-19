require_relative "room"

class Hotel
  
    def initialize(name, capacities)
        @name = name
        @room = {}

        capacities.each do |room_name, capacity|
            @room[room_name] = Room.new(capacity)
        end
    end

    def name
# capitalize(ex:"book room" => "Book Room") but storing in map so use join to return str
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def room
        @room
    end

    def room_exists?(name)
        @room.has_key?(name)
    end

    def check_in(person, room)
        if self.room_exists?(room)
            if @room[room].add_occupant(person)
                puts " check in successful"
            else
                puts " sorry, room is full"
            end
        else
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
        @room.values.any? { |room| room.available_space > 0}
    end

    def list_rooms
        @room.each do |room_name, room|
            puts "#{room_name} : #{room.available_space}"
        end 
    end

end
