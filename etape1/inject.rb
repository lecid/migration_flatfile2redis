require 'fileutils'

puts 'Start injections :'
root_path = '/tmp/legacy-switch'
file_tree = {'input' => ['data1.txt','data2.txt', 'data3.txt'],
             'archive' => ['data4.txt','data5.txt','data6.txt'],
             'error' => ['data7.txt','data8.txt','data9.txt','data10.txt']}


print ' * Check root path'
FileUtils.mkdir_p root_path unless File::exist?(root_path)
puts ' done'

print ' * Check spool paths'
file_tree.keys.each do |folder|
  path = "#{root_path}/#{folder}"
  FileUtils.mkdir_p path unless File::exist?(path)
end
puts ' done'

print ' * Populate files in spools'
file_tree.each do |path, filenames|
  filenames.each do |filename|
    File::rm(filename) if File::exist?(filename)  
    File.open("#{root_path}/#{path}/#{filename}", 'w') { |file| file.write("content of file #{filename}") }
  end
end
puts ' done'
  


              
