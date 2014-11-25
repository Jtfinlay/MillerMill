require './game_controller'

class ClientHandler

  @games

  def initialize(games)
    @games = games
  end

  def hello
    return @games.keys
  end

  def join(gid)
    if !@games.has_key?(gid)
      @games[gid] = GameController.new
    else
      @games[gid].add_player
    end
    return [@games[gid].type, @games[gid].players]
  end

  def setup(gid, type)
    @games[gid].setup(type)
  end

  def player_count(gid)
    return @games[gid].players
  end

end
