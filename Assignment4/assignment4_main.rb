# Note - Need Ruby 1.9.3 for GTK2

require './game_controller'

puts "What type of game would you like to play?"
puts "Enter 1 for normal and 2 for OTTO/TOOT"

begin
  i = gets
rescue Interrupt
end
if i.to_i != 1 and i.to_i != 2
  puts "Please enter 1 or 2"
  exit
end

c = GameController.new(i.to_i)

Thread.new { 
  begin
    while true
      puts "Enter a column (0-indexed) and type of token (1 for X, 2 for O, 3 for T"
      print ">"
      cmd = gets.chomp
      a = cmd.split[0].to_i
      b = cmd.split[1].to_i
      c.column_press(a, b) if a >= 0 and a < 7 and b > 0 and b < 4
    end
  rescue Exception => e
    puts e
  end
}


c.start_game
