# Note - Need Ruby 1.9.3 for GTK2

require './game_controller'

puts "What type of game would you like to play?"
puts "Enter 1 for normal and 2 for OTTO/TOOT"

i = gets

if i.to_i != 1 and i.to_i != 2
  puts "Please enter 1 or 2"
  exit
end

c = GameController.new(i.to_i)

Thread.new {
  while true
    print ">"
    cmd = gets.chomp

    c.column_press(cmd.to_i, 1)
  end
}


c.start_game
