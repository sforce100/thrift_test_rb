#
# Autogenerated by Thrift Compiler (0.9.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'r_types'

module QService
  class Client
    include ::Thrift::Client

    def exponent(base, exp)
      send_exponent(base, exp)
      return recv_exponent()
    end

    def send_exponent(base, exp)
      send_message('exponent', Exponent_args, :base => base, :exp => exp)
    end

    def recv_exponent()
      result = receive_message(Exponent_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'exponent failed: unknown result')
    end

    def get_key(l)
      send_get_key(l)
      return recv_get_key()
    end

    def send_get_key(l)
      send_message('get_key', Get_key_args, :l => l)
    end

    def recv_get_key()
      result = receive_message(Get_key_result)
      return result.success unless result.success.nil?
      raise result.e unless result.e.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get_key failed: unknown result')
    end

    def run_task()
      send_run_task()
    end

    def send_run_task()
      send_message('run_task', Run_task_args)
    end
  end

  class Processor
    include ::Thrift::Processor

    def process_exponent(seqid, iprot, oprot)
      args = read_args(iprot, Exponent_args)
      result = Exponent_result.new()
      result.success = @handler.exponent(args.base, args.exp)
      write_result(result, oprot, 'exponent', seqid)
    end

    def process_get_key(seqid, iprot, oprot)
      args = read_args(iprot, Get_key_args)
      result = Get_key_result.new()
      begin
        result.success = @handler.get_key(args.l)
      rescue ::InvalidKey => e
        result.e = e
      end
      write_result(result, oprot, 'get_key', seqid)
    end

    def process_run_task(seqid, iprot, oprot)
      args = read_args(iprot, Run_task_args)
      @handler.run_task()
      return
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class Exponent_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    BASE = 1
    EXP = 2

    FIELDS = {
      BASE => {:type => ::Thrift::Types::I32, :name => 'base'},
      EXP => {:type => ::Thrift::Types::I32, :name => 'exp'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Exponent_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Get_key_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    L = 1

    FIELDS = {
      L => {:type => ::Thrift::Types::STRUCT, :name => 'l', :class => ::Lookup}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Get_key_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0
    E = 1

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'},
      E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::InvalidKey}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_task_args
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Run_task_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

