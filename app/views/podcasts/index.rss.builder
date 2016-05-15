author = "Kelly MacLean"
image_url = "https://s3.amazonaws.com/tao-of-comedy-production/itunes_coverart.jpg"
keywords = "comedy, meaning of life, "

xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "The Tao of Comedy"
    xml.link "http://www.taopodcast.com"
    xml.description "The Tao of Comedy Podcast with Kelly MacLean"
    xml.pubDate @podcasts.first.release_date.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.published_at.to_s(:rfc822)
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

    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'kellymacleancomedy@gmail.com'
    end

    # xml.itunes :category, text: 'Comedians' do
    #   xml.itunes :category, text: 'Comdey'
    # end

    # xml.itunes :category, text: 'Comedy' do
    #   xml.itunes :category, text: 'Comedians'
    # end

    @podcasts.each do |podcast|
      xml.item do
        xml.title podcast.title
        xml.link "http://www.taopodcast.com"
        xml.description podcast.description
        xml.pubDate podcast.release_date.to_s(:rfc822)
        xml.guid podcast.recording_url
        xml.itunes :author, author
        xml.itunes :summary, podcast.description
        xml.itunes :subtitle, truncate(podcast.description, length: 150)
        xml.itunes :explicit, "yes"
        # xml.itunes :duration, podcast.duration
      end
    end
  end
end
