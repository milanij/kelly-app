class PagesController < ApplicationController

  def about
    render "about", layout: "layouts/application"
  end

  def news
    render "news", layout: "layouts/application"
  end

  def calendar
    render "calendar", layout: "layouts/application"
  end

  def photos
    render "photos", layout: "layouts/application"
  end

  def videos
    render "videos", layout: "layouts/application"
  end

  def contact
    render "contact", layout: "layouts/application"
  end

end
