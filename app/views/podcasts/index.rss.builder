@podcasts.each do |podcast|

  xml.instruct! :xml, version: "1.0"
  xml.rss version: "2.0" do
    xml.channel do
      xml.title podcast.title
      xml.description podcast.description
      xml.link podcast_url(podcast.id)
    end
  end
end
