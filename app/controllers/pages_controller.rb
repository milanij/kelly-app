require "stripe"

class PagesController < ApplicationController

  skip_before_action :verify_authenticity_token

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

  def donate
    render "donate", layout: "layouts/application"
  end

  def donate_process
    begin
      # Amount in cents
      @amount = params[:amount]

      customer = Stripe::Customer.create(
        :email  => params[:email],
        :source => params[:id]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Donation',
        :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/donate'
      return
    else
      render json: {}, status: 200
    end
  end

end
