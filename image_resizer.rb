require 'sinatra'
require 'RMagick'
require 'net/http'
require 'uri'

get '/*x*' do |width, height|
  uri = URI.parse(params[:url])
  random_number = rand
  Dir.mkdir "tmp" unless Dir.exists? "tmp"
  output_doc = "tmp/file#{random_number}"
  output_thumb = "tmp/thumb#{random_number}"
  # `wget --output-document=#{output_doc} #{params[:url]}`
  # Must be somedomain.net instead of somedomain.net/, otherwise, it will throw exception.
  Net::HTTP.start(uri.host) do |http|
    resp = http.get(uri.path)
    open(output_doc, "wb") do |file|
      file.write(resp.body)
    end
  end
  img = Magick::Image::read(output_doc).first
  thumb = img.resize_to_fit(width, height)
  thumb.write output_thumb
  send_file output_thumb
end