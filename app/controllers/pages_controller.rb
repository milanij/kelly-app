require 'stripe'

class PagesController < ApplicationController
  layout 'layouts/application', except: [ :donate_process ]

  def about
  end

  def news
  end

  def calendar
  end

  def photos
  end

  def videos
  end

  def contact
  end

  def donate
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
