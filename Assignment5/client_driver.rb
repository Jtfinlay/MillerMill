require 'xmlrpc/server'
require 'xmlrpc/client'

class ClientDriver

  attr_accessor :pname

  def initialize
  end

  def start(host, port)

    server = XMLRPC::Client.new(host, "/", port)
    manager = server.proxy("manager")

    # TODO - If not connected, throws ERRNO:ECONNREFUSED

    @pname = ask_player_name

    # Launch client server
    launch_listener(2020)

#    puts manager.hello
    
    puts manager.connect(@pname, "localhost", 2020)
    puts manager.action(@pname)

    gets  
  end

  def test
    return "test"
  end

  def ask_player_name
    puts "Please enter your username,"
    return gets
  end

  def launch_listener(port)
    Thread.new {
      s = XMLRPC::Server.new(port)
      s.add_handler("client", self)
      s.serve
    }
  end

  

end

