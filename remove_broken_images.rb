require 'mini_magick'

files =  Dir["./collections/default/*"]

to_d = []

files.each do |f|
  File.open(f, 'rb') do |file|
    to_d << f if file.read.length == 0
  end
end

to_d.each do |f|
  puts "Deleting bad files..."
  File.delete(f)
end