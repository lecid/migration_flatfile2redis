
require 'forwardable'

print 'Init Forwardable spool'

class Spooler

    attr_reader :default
    extend Forwardable
    def_delegators :@default_backend, :list, :get , :spool, :spool=, :create, :update

    def initialize (options = {})
        @default  = options[:default]
        spool  = (options[:spool])? options[:spool] : 'input'
        @BE = {:redis => ::Backends::Redis::new, :file => ::Backends::File::new }
        @default_backend = @BE[@default]
    end


    def delete(options)
        @BE.values.each {|be| be.delete(options)}
    end

    def upsert(options)
        @BE.values.each {|be| be.upsert(options)}
    end


end

puts ' done'