require 'httparty'

$urls = []
$page = 1

# Adjustable parameters
$max_page     = 10                  # The number of pages to gather images from.
$max_per_page = '1000'              # Number of posts per page ($max_page)
$subreddit    = 'pics'              # The subreddit to gather images from
$start_date   = '1559151716'        # Starting date. Every image gathered will have been posted before this date.
$img_formats  = /jpg|jpeg/          # White list of acceptable file types
$valid_urls   = /imgur.com|redd.it/ # White list of acceptable sources

# Retrives list of image urls from Reddit, saving them to $urls var.
#
# ACCEPTS: (String) containing timestamp denoting latest date to search for.
# RETURNS: (Nil) Noting
# NOTES:   Method is recursive.
def pages(time)

  response = HTTParty.get("https://api.pushshift.io/reddit/search/submission/?subreddit=#{$subreddit}&sort=desc&sort_type=created_utc&size=#{$max_per_page}&search?before=#{time}")
  json = JSON.parse(response.body)

  json["data"].each do |f|
    $urls << [f["created_utc"], f["url"]] if f["url"].match?($img_formats) && f["url"].match?($valid_urls)
  end

  if $page < $max_page
    sleep(rand(2..5))
    $page += 1
    pages($urls.last[0])
  else
    write_file
  end

end

# Writes $urls to file.
#
# ACCEPTS: Nothing
# RETURNS: (Nil) Nothing
def write_file
  File.open("image_urls.txt", "a") do |a|
    $urls.each do |f|
      a << "#{f[1]}\n"
    end
  end
end

pages($start_date)