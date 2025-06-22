print "init backend File"

module Backends
    class File

        attr_accessor :spool

        def initialize(options={})
            @root_path = (options[:root_path])? options[:root_path] : '/tmp/legacy-switch'
            @spool = options[:spool]
            @default_ext = ".txt"
        end


        def list 
            return ::Dir["#{@root_path}/#{@spool}/*#{@default_ext}"].map! {|filename| filename = ::File.basename(filename,@default_ext) }
        end 

        def get(options = {})
            return ::File.read("#{@root_path}/#{@spool}/#{options[:entry]}#{@default_ext}")
        end

        def delete(options)
            ::File.delete("#{@root_path}/#{@spool}/#{options[:entry]}#{@default_ext}") 
        end


        def upsert(options ={})
            ::File.open("#{@root_path}/#{@spool}/#{options[:entry]}#{@default_ext}", 'w') { |file| file.write(options[:data]) }
        end


        def exist?(options)
            return ::File.exist?("#{@root_path}/#{@spool}/#{options[:entry]}#{@default_ext}")
        end
    
        def flush
            Dir.glob("#{@root_path}/#{@spool}/*#{@default_ext}").each { |file| ::File.delete(file)}
        end

        alias :update :upsert
        alias :create :upsert

    end 
end

puts ' done'