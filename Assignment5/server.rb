require 'xmlrpc/socket'

class Server

  @games

  def initialize()
    @games = Hash.new
  end

  def start(port)
    s = XMLRPC::Server.new(port)

    s.add_handler("manager", ClientHandler.new(s))

    s.serve
  end

end

s = Server.new
s.start(2014)
