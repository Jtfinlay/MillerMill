require './game_controller'

class ClientHandler

  @games

  def initialize(games)
    @games = games
  end

  def hello
    return @games.keys
  end

  def join(gid, pname)
    if !@games.has_key?(gid)
      @games[gid] = GameController.new
    end
    pid = @games[gid].add_player(pname)
    return [@games[gid].type, @games[gid].width, @games[gid].height, pid]
  end

  def setup(gid, type)
    @games[gid].setup(type)
  end

  def players(gid)
    return @games[gid].players
  end

  def press_column(gid, pid, column, value)
    return @games[gid].column_press(pid, column, value)
  end

  def get_player_turn(gid)
    return @games[gid].player_turn
  end

  def get_turns(gid)
    return @games[gid].turn_count
  end

  def get_game_state(gid)
    return [@games[gid].message,
            @games[gid].board.data, 
            @games[gid].players, 
            @games[gid].turn_count]
  end

end
