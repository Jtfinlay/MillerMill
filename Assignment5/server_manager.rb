require 'xmlrpc/server'
require 'xmlrpc/client'

class ServerManager
 

  attr_accessor :games, :clients


  def initialize(port)
    @games = Hash.new
    @clients = Hash.new

    s = XMLRPC::Server.new(port)
    s.add_handler("manager", self)
#    puts s.inspect
#    puts s.Port

    s.serve
  end

  def connect(player_name, ip_addr, port)

    s = XMLRPC::Client.new(ip_addr, "/", port)
    @clients[player_name] = s.proxy("client")
    
    return "sup #{ip_addr}, #{port}"
  end

  def action(player_name)
    return @clients[player_name].test
  end

end
