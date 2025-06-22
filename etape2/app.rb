



require_relative 'lib/backends/init'
require_relative 'lib/init'



class Application < Sinatra::Base

    def initialize(*args)
        super(args)

        puts 'Starting application'
        #@spooler = ::Backends::File::new spool: 'input'

        @backend = ::Backends::File # need DI or config mapping in prod
        @spooler = ::Spooler::new backend: @backend

        puts "Applications Init. "
    end

    get "/get/:name" do |name|  
        @spooler.spool = name
        @name = name 
        @data =  []
        @spooler.list.each do |item|
            @data.push({:name => item, :content => @spooler.get({:entry => item})}) 
        end 
        erb :spool 
    end


end


