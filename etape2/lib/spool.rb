
require 'forwardable'

print 'Init Forwardable spool'

class Spooler

    extend Forwardable
    def_delegators :@backend, :list, :get , :spool, :spool=, :delete, :upsert, :create, :update

    def initialize (options = {})
        spool  = (options[:spool])? options[:spool] : 'input'
        @backend = options[:backend]::new spool: spool
    end

end

puts ' done'