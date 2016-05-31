author = "Kelly MacLean"
image_url = "https://s3.amazonaws.com/tao-of-comedy-production/itunes_coverart.jpg"
# keywords = "comedy, spirituality, humor, comedians, comics, stand up, entertainment industry, grief, grieving, death, existentialism, philosophy, funny, religion, god, mindfulness"
keywords = "comedy, spirituality, humor, comedians, comics, stand up, entertainment, grief, grieving, death, philosophy, funny, god, religion, mindfulness"
description = "Following the sudden death of her beloved brother, host Kelly MacLean asks fellow comedians to aid her in an existential search for the of meaning of life. Hilarious and poignant, The Tao of Comedy exposes comedians as the sages they secretly are."

xml.instruct! :xml, version: "1.0"
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do
    xml.title "The Tao of Comedy"
    xml.link "http://www.taopodcast.com"
    xml.description description
    xml.pubDate @podcasts.first.release_date.to_s(:rfc822)
    xml.lastBuildDate @podcasts.first.release_date.to_s(:rfc822)
    xml.language "en-us"

    xml.image do
      xml.url image_url
      xml.title "The Tao of Comedy"
      xml.link "http://www.taopodcast.com"
    end

    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, "yes"
    xml.itunes :image, href: image_url
    xml.itunes :summary, description

    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'kellymacleancomedy@gmail.com'
    end

    xml.itunes :category, text: 'Comedy'

    xml.itunes :category, text: 'Religion & Spirituality'

    @podcasts.each do |podcast|
      xml.item do
        if podcast.visible?
          xml.title podcast.title
          xml.link podcast.recording_url
          xml.description podcast.description.html_safe
          xml.pubDate podcast.release_date.to_s(:rfc822)
          xml.guid podcast.recording_url
          xml.itunes :author, author
          xml.itunes :summary, podcast.description.html_safe
          xml.itunes :subtitle, podcast.description.html_safe
          xml.itunes :explicit, "yes"
          # xml.itunes :duration, "1:15"
          xml.enclosure(
            url: podcast.recording_url,
            length: podcast.file_size,
            type: "audio/mpeg"
          )
        end
      end
    end
  end
end
