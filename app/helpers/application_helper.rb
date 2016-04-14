# encoding: UTF-8

module ApplicationHelper

  def post?
    params[:controller] == "posts" && params[:action] == "show" ? true : false
  end

  def podcast?
    params[:controller] == "podcasts" && params[:action] == "show" ? true : false
  end

  def nice_boolean( b )
    b ? '✅' : '🚫'
  end
end
