$:.push('./gen-rb')
$:.unshift './rb/lib'

# require "rubygems"
# require "bundler/setup"
require 'thrift'
require 'q_service'

# provide an implementation of QService
class QServiceHandler
  def initialize()
    @log = {}
    @hash = {'bucket1' => {'key1' => 'value1'}}
  end

  def exponent(base, exp)
    print "#{base}**#{exp}\n"
    return base**exp
  end

  def get_key(lookup)
   if @hash[lookup.bucket]
     return @hash[lookup.bucket][lookup.key]
   else
     e = InvalidKey.new
     e.error = 'Cache miss'
     raise e
   end
  end

  def run_task()
    print "kick off long running task...\n"
  end

end

# Thrift provides mutiple communication endpoints
#  - Here we will expose our service via a TCP socket
#  - Web-service will run as a single thread, on port 9090

handler = QServiceHandler.new()
processor = QService::Processor.new(handler)
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::SimpleServer.new(processor, transport, transportFactory)

puts "Starting the QService server..."
server.serve()
puts "Done"
