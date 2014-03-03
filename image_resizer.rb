require 'sinatra'
require 'RMagick'
require 'net/http'

get '/*x*' do |width, height|
  puts width, height, params[:url]
  random_number = rand
  output_doc = "tmp/file#{random_number}"
  output_thumb = "tmp/thumb#{random_number}"
  puts "wget --output-document=#{output_doc} #{params[:url]}"
  `wget --output-document=#{output_doc} #{params[:url]}`
  img = Magick::Image::read(output_doc).first
  thumb = img.resize_to_fit(width, height)
  thumb.write output_thumb
  send_file output_thumb
end