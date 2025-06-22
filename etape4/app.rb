



require_relative 'lib/backends/init'
require_relative 'lib/init'



class Application < Sinatra::Base

    def initialize(*args)
        super(args)
        puts 'Starting application'
        @spooler = ::Spooler::new default: :redis 
        puts "Applications Init. "
    end

    get "/get/:name" do |name|  
        @backend = @spooler.default
        @spooler.spool = name
        @name = name 
        @data =  []
        @spooler.list.each do |item|
            @data.push({:name => item, :content => @spooler.get({:entry => item})}) 
        end 

        erb :spool 
    end


end


