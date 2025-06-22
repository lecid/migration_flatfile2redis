require_relative 'lib/backends/init'

puts 'Start Sync (ROLLBACK) : '
['input','archive','error'].each do |spool|
    print "* Sync : #{spool}"
    fileBE = ::Backends::File::new spool: spool
    redisBE = ::Backends::Redis::new spool: spool
    redisBE.flush
    redisBE.list.each do |entry|
        fileBE.create entry: entry, data: fileBE.get({entry: entry})
    end
    puts ' done'
end


              
