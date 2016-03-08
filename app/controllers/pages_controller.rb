class PagesController < ApplicationController

  def homepage
    render "homepage", layout: "layouts/application"
  end

end
