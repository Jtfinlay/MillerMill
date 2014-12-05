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

  def save_game(id, board, turn)
    begin
      r = @con.query("SELECT * FROM saves WHERE id = '#{id}'")
      return false if r.num_rows > 0
      r = @con.query("INSERT INTO saves (id, board, turn) 
              VALUES
                ('#{id}','#{serialize_board(board)}', #{turn})"
          )
    rescue Mysql::Error => e
      puts e.error
    end
    return true
  end

  def load_game(id)
    begin
      r = @con.query("SELECT * FROM saves WHERE id = '#{id}'")
    rescue Mysql::Error => e
      puts e.error
    end
    return "Game does not exist!", 0 if r.num_rows == 0
    board = ''
    turn = 0
    r.each_hash do |row|
      board = row['board']
      turn = row['turn']
    end
    return deserialize_board(board), turn
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
    puts s
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
