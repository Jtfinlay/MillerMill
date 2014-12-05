require './server_manager'

if ARGV.length != 2
  puts "Two arguments required: server hostname and port"
  exit  
end
s = ServerManager.new(ARGV[0],ARGV[1].to_i)
