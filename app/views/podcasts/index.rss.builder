xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.title "The Tao of Comedy"
  xml.language "en-us"
  xml.channel do
    xml.image do
      xml.url ""
      xml.title "The Tao of Comedy"
      xml.link "http://www.taopodcast.com"
    end
    @podcasts.each do |podcast|
      xml.item do
        xml.title podcast.title
        xml.link "http://www.taopodcast.com"
        xml.description podcast.description
        xml.pubDate podcast.release_date
        xml.guid podcast.recording.url
      end
    end
  end
end
