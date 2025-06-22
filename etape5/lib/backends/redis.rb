print "init backend Redis"

require 'redis'

module Backends
    class Redis

        attr_accessor :spool

        def initialize(options={})
            @spool = options[:spool]
            spoolmap = {'input' => 10 , 'archive' => 11 , 'error' => 12}
            conf = { :host => 'localhost', :port => '6379', :db => spoolmap[@spool]}
            @store = ::Redis.new conf
        end


        def list 
            return @store.keys('*')
        end 

        def get(options = {})
            return @store.get(options[:entry])
        end

        def delete(options)
            @store.del options[:entry]
        end


        def upsert(options ={})
            @store.set options[:entry], options[:data]
        end

        alias :update :upsert
        alias :create :upsert

        def exist?(options = {})
            return ( not @store.get(options[:key]).nil? )
          end

        def flush 
            @store.flushdb
        end

    end 
end

puts ' done'