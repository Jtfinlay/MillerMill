require 'xmlrpc/server'
require 'xmlrpc/client'

class ServerManager
 
  attr_accessor :games, :clients

  def initialize(port)
    @games = Hash.new
    @clients = Hash.new

    s = XMLRPC::Server.new(port)
    s.add_handler("manager", self)
    s.serve
  end

  def connect(player_name, ip_addr, port)

    s = XMLRPC::Client.new(ip_addr, "/", port)
    @clients[player_name] = s.proxy("client")

    # TODO - If not connected, throws ERRNO:ECONNREFUSED
    
    return [true, "Connection established."]
  end

  def join(gid, pid)
    return false if !@games.has_key?(gid)

    @games[gid].add_player(pid)
    return true
  end

  def create(gid, pid, type)
    return join(gid,pid) if @games.has_key?(gid)
 
    #@games[gid] = GameController.new(type)
    #@games[gid].add_player(pid)
    return 0
  end

  def action(player_name)
    return @clients[player_name].test
  end

end
