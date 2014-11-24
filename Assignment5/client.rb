require 'socket'

class Client

  def initialize
  end

  def start(host, port)
    clientSession = TCPSocket.new(host, port)

    puts "starting connection"
    clientSession.puts "Client: Hello Server!\n"

    while !(clientSession.closed?) && (serverMessage = clientSession.gets)
      puts serverMessage
      if serverMessage.include?("Goodbye")
        puts "closing connection"
        clientSession.close
      end
    end
  end
end

c = Client.new
c.start("localhost", 2014)
