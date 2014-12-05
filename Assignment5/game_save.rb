require 'mysql'
require './game_board'


class GameSave 
  @con

  def initialize(host, user, pwd, db, port)
    begin
      @con = Mysql.new(host, user, pwd, db, port)
    rescue Mysql::Error => e
      puts e.error
    end
  end

  def save_game(id, board, turn, type)
    begin
      r = @con.query("SELECT * FROM saves WHERE id = '#{id}'")
      return false if r.num_rows > 0
      r = @con.query("INSERT INTO saves (id, board, turn, type) 
              VALUES
                ('#{id}','#{serialize_board(board)}', #{turn}, #{type})"
          )
    rescue Mysql::Error => e
      puts "SQL Error while saving"
      puts e.error
    end
    return true
  end

  def load_game(id)
    begin
      r = @con.query("SELECT * FROM saves WHERE id = '#{id}'")
    rescue Mysql::Error => e
      puts "SQL Error while loading"
      puts e.error
    end
    return "Game does not exist!", 0 if r.num_rows == 0
    board = ''
    turn = 0
    type = 1
    r.each_hash do |row|
      board = row['board']
      turn = row['turn'].to_i
      type = row['type'].to_i
    end
    begin
      r = @con.query("DELETE FROM saves WHERE id = '#{id}'")
    rescue Mysql::Error => e
      puts "SQL Error while deleting save"
      puts e.error
    end
    return deserialize_board(board), turn, type
  end

  def serialize_board(board)
    s = ''
    board.data.each{ |x|
      x.each { |n|
        s += n.to_s
      }
    }
    return s
  end

  def deserialize_board(s)
    board = GameBoard.new(7,6)
    i = 0
    j = 0
    k = 0
    s.split("").each{ |n|
      board[i,j] = n.to_i
      k += 1
      i = k / 7
      j = k % 7
    }
    return board
  end
end
