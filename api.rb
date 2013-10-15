require "sinatra"
require "nokogiri"
require 'open-uri'
require "json"

def ad_url(buyitem, zipcode)
  "http://ad.where.com/jin/spotlight/ads?context=WA&format=html&ip=38.44.234.343&netid=CAMP_#{buyitem}&placementtype=320x50&pubid=test&ua=Mozilla&v=2.4&zip=#{zipcode}"
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

get "/ads/:buyitem/:zipcode" do
  content_type 'application/json'
  doc = Nokogiri::HTML(open(ad_url(params['buyitem'], params['zipcode'])))
  url = doc.search("a").first.attribute("href").value
  image = doc.search("img").first.attribute("src").value
  {
    :image => image,
    :url => url
  }.to_json
end
