$:.push('./gen-rb')
$:.push('./rb/lib')

require 'r_constants'
require 'r_types'
require 'thrift'
require 'q_service'


begin
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = QService::Client.new(protocol)

  transport.open()

  # Run a remote calculation
  answer = client.exponent(50,2)
  print "50**2=", answer, "\n"

  # Run a 'cache' lookup
  lookup = Lookup.new()
  lookup.bucket = 'bucket1'
  lookup.key = 'key1'

  print "Lookup: ", client.get_key(lookup), "\n"

  # Force a cache miss
  begin
    lookup.bucket = 'bucket2'
    print "Lookup: ", client.get_key(lookup), "\n"
  rescue InvalidKey => e
    print "InvalidKey: ", e.error, "\n"
  end

  print client.run_task()


rescue Thrift::Exception => tx
  print 'TException: ', tx.message, "\n"
ensure
  transport.close()
end

