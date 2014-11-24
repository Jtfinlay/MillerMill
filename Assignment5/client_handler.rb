
class ClientHandler

  @server

  def initialize(server)
    @server = server
  end

  def hello
    return "ACK"
  end

  def join(gid)
  end

  def await(gid)

  end
end
