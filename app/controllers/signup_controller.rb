class SignupController < ApplicationController
  def index
    enqueue_mix_panel_event "Visits Signup Sub Page"
  end

  def create
    venue = Venue.new(
      name: params[:restaurant_name],
      address: params[:restaurant_address],
      city: params[:restaurant_city],
      zip: params[:restaurant_zip],
      neighborhood: params[:restaurant_neighborhood],
      web: params[:website],
      facebook: params[:facebook],
      twitter: params[:twitter],
      instagram: params[:instagram],
      email: params[:email],
      social_media_email: params[:social_contact],
      first_name: params[:first_name],
      last_name: params[:last_name],
      cc_num: params[:cc],
      cc_expm: params[:exp].split('/').first,
      cc_expy: params[:exp].split('/').second,
      cc_zip: params[:zip],
      cc_cvv2: params[:cvv],
      visible: false
    )

    if venue.save
      offer = venue.offers.new(
        name: params[:first_dish],
        original_price: params[:first_dish_price]
      )
      offer.save

      flash.now[:success] = "Thanks for signing up! We'll review your submission shortly."
    else
      flash.now[:errors] = venue.errors.full_messages
    end

    render :index
  end
end
