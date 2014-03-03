require 'sinatra'
require 'RMagick'
require 'net/http'
# require 'haml'

# get '/upload' do
#   haml :upload
# end

# # Handle POST-request (Receive and save the uploaded file)
# post "/upload" do
#   File.open('uploads/' + params['myfile'][:filename], "w") do |f|
#     f.write(params['myfile'][:tempfile].read)
#   end
#   return "The file was successfully uploaded!"
# end

get '/*x*' do |width, height|
  puts width, height, params[:url]
  random_number = rand
  output_doc = "tmp/file#{random_number}"
  output_thumb = "tmp/thumb#{random_number}"
  puts "wget --output-document=#{output_doc} #{params[:url]}"
  `wget --output-document=#{output_doc} #{params[:url]}`
  img = Magick::Image::read(output_doc).first
  thumb = img.resize_to_fit(125, 125)
  thumb.write output_thumb
  send_file output_thumb
end