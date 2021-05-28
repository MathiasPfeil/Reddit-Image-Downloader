require 'open-uri'

arr = File.readlines('./image_urls.txt')
line_size = arr.length

arr.each_with_index do |f,i|

  clean_url = f.gsub("\n","")

  begin
    puts "Downloading image number #{i} of #{line_size}"
    open("collections/default/#{File.basename(clean_url)}", 'wb') do |file|
      file << open(clean_url).read
    end
    sleep(0.5)
  rescue
    puts "Whoops... Could not save image."
  end
end