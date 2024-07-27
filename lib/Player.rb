class Player
  attr_accessor :colour, :is_human

  def initialize(colour, is_human = true)
    @colour = colour
    @is_human = is_human
  end

  def take_action(active=nil)
    puts "\n#{active.colour}, put M if you want to move a piece & W if you want to withdraw"
    command = gets.chomp

    if command == 'W'
      return 'withdraw'
    elsif command == 'M'
      puts "Please put y, x coordinates of the piece that you want to move - eg. 1,0 for white pawn"
      source = gets.chomp.split(',').map(){ |item| item.to_i }

      puts "Please put y, x coordinates of your destination - eg 4,3"
      destination = gets.chomp.split(',').map(){ |item| item.to_i }

      return [source, destination]
    else
      puts "pls give correct command"
      take_action(active)
    end
  end
end

# p Player.new.take_action()
