require 'xmlrpc/client'

class GameClient

  def initialize
  end

  def start(host, port)
    server = XMLRPC::Client.new(host, "/", port)
    manager = server.proxy("manager")


    puts "#{manager.hello}"
  end

end

c = GameClient.new
c.start("localhost", 2014)
