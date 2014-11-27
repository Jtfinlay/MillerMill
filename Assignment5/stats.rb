require 'mysql'

class Stats
  @host
  @user
  @pwd
  @db
  @port
  @con

  def initialize(host, user, pwd, db, port)
    @host = host
    @user = user
    @pwd = pwd
    @db = db
    @port = port
    begin
      @con = Mysql.new(host, user, pwd, db, port)
    rescue Mysql::Error => e
      puts e.error
    end
  end

  def add_stat(game_id, p1, p2, winner)
    begin
      @con.query("INSERT INTO games (id, p1, p2, winner) 
              VALUES
                ('#{game_id}','#{p1}','#{p2}','#{winner}')"
          )
    rescue Mysql::Error => e
      puts e.error
    end
  end

  def get_game(game_id)
    begin
      r = @con.query("SELECT * FROM games WHERE id = '#{game_id}'")
    rescue Mysql::Error => e
      puts e.error
    end
    return "Game does not exist" if r.num_rows == 0
    result = ''
    r.each_hash do |row|
      result += "Game ID: #{row['id']}, P1: #{row['p1']}, P2: #{row['p2']}, Winner: #{row['winner']}\n"
    end
    return result  
  end

  def get_player(id)
    begin  
      r = @con.query("SELECT * FROM games WHERE p1 = '#{id}' or p2 = '#{id}'") 
    rescue Mysql::Error => e
      puts e.error
    end
    return "Player has not played any games" if r.num_rows == 0
    won_games = 0
    r.each_hash do |row|
      won_games += 1 if row['winner'] == id
    end 
    return "Player: #{id}\nGames Played: #{r.num_rows}\nGames Won:#{won_games}"
  end

  def get_league_stats
    begin
      r = @con.query("SELECT winner, count(winner) FROM games GROUP BY winner ORDER BY count(winner) DESC LIMIT 10")
    rescue Mysql::Error => e
      puts e.error
    end
    result = "League Standings\n"
    i = 1
    r.each_hash do |row|
      result += "#{i}: #{row['winner']} - #{row['count(winner)']} wins\n"
      i += 1
    end
    return result    
  end
end

s = Stats.new("mysqlsrv.ece.ualberta.ca", "ece421grp7",'Afbgt7oE', 'ece421grp7', 13010)
puts s.get_league_stats
