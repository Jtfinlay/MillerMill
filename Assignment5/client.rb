require 'xmlrpc/client'

class Client

  def initialize
  end

  def start(host, port)
    server = XMLRPC::Client.new(host, "", port)
    manager = server.proxy("manager")


    puts "#{manager.hello}"
  end

end

c = Client.new
c.start("localhost", 2014)
