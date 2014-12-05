require './client_driver'

if ARGV.size != 3
  puts "Two arguments required: server hostname, server port, and client port(Different than server port)"
  exit
end
c = ClientDriver.new
c.start(ARGV[0], ARGV[1].to_i, ARGV[2].to_i)
