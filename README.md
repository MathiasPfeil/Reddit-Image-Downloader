# Reddit Image Downloader

Scripts I use to download large sets of images from Reddit. Great for building image datasets.

## How to use

Files should be run in the order they are listed below.

### get_image_urls.rb
`ruby get_image_urls.rb`

Gathers a list of image urls from posts created in the subreddit of your choosing. All of these urls are then saved to `image_urls.txt` in the main directory.

The variables listed below are found at the top of `get_image_urls.rb`. They are the adjustable parameters you can change to your needs.

```
# Adjustable parameters
$max_page     = 10                  # The number of pages to gather images from.
$max_per_page = '1000'              # Number of posts per page ($max_page)
$subreddit    = 'pics'              # The subreddit to gather images from
$start_date   = '1559151716'        # Starting date. Every image gathered will have been posted before this date.
$img_formats  = /jpg|jpeg/          # White list of acceptable file types
$valid_urls   = /imgur.com|redd.it/ # White list of acceptable sources
```

### download.rb
`ruby download.rb`

This file opens `image_urls.txt` (created in previous step) and downloads the images from the urls. Those images will then be saved in the /collections/default directory.

### remove_broken_images.rb
`ruby remove_broken_images.rb`

The final file run (optional). A few of the images downloaded from the previous step will be in a valid format, but will be broken. The exact cause I have not looked into. If you want to remove these files, `remove_broken_images.rb` will do the trick.

## Requirements

* Only tested on Ruby 2.7.1
* ImageMagick
* httparty
* mini_magick