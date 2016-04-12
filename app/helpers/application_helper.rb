module ApplicationHelper

  def post?
    params[:controller] == "posts" && params[:action] == "show" ? true : false
  end

  def podcast?
    params[:controller] == "podcasts" && params[:action] == "show" ? true : false
  end
end
