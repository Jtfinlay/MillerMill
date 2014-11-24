require 'socket'

class Server

  def initialize()
  end

  def start(port)
    server = TCPServer.new(port)

    while (session = server.accept)

      Thread.start do
        puts "Log: Connection from #{session.peeraddr[2]} at #{session.peeraddr[3]}"

        input = session.gets
        puts input

        session.puts "Server: Sup yo gurl\n"
        session.puts "Server: Goodbye\n"
    end
  end

end

s = Server.new
s.start(2014)
