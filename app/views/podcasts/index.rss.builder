xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.title "The Tao of Comedy"
  xml.language "en-us"
  xml.channel do
    @podcasts.each do |podcast|
      xml.item do
        xml.title podcast.title
        xml.description podcast.description
        xml.link "http://www.taopodcast.com"
      end
    end
  end
end
