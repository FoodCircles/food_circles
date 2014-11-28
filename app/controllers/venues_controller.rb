class VenuesController < ApplicationController

  def index

    params[:lat] = nil if ['null'].include? params[:lat]

    if params[:offline]
      begin
        @venues = (lat(params[:lat]) ? Venue.active.not_available_with_location(params[:lat],params[:lon]) : Venue.active.not_available)
        if !@venues || !@venues.any?
          @venues = Venue.active.not_available
        end
      rescue
        @venues = Venue.active.not_available
      end
    else
      begin
        @venues = (lat(params[:lat]) ? Venue.active.currently_available_with_location(params[:lat],params[:lon]) : Venue.active.currently_available)
        if !@venues || !@venues.any?
          @venues = Venue.active.currently_available
        end
      rescue
        @venues = Venue.active.currently_available
      end
    end



    if ['json','jsonp'].include?(params[:format])
      if (params[:offline])
        render :json => (lat(params[:lat]) ? @venues.as_json(:lat => params[:lat], :lon => params[:lon], :not_available => true) : @venues), :callback => params[:callback]
      else
        render :json => (lat(params[:lat]) ? @venues.as_json(:lat => params[:lat], :lon => params[:lon]) : @venues), :callback => params[:callback]
      end
    end
  end

  def show
    # @v = Venue.find(params[:id])
    @offer = Venue.find(params[:id]).offers.first

    if ['json','jsonp'].include?(params[:format])
        render :json => @v, :callback => params[:callback]
    end
  end

  def subscribe
    partial, message = if current_user
      venue = Venue.find(params[:id])
      user = current_user
      notification_request = NotificationRequest.new(:venue => venue, :user => current_user)
      if notification_request.save
        ['subscribe_success', 'Got it. Look for an email next week.']
      else
        ['subscribe_success', "Hang tight- we'll email you, promise."]
      end
    else
      ['subscribe_error', 'Sign up to get notified.']
    end

    respond_to do |format|
      format.js{ render partial, locals: {message: message} }
    end
  end

  def unsubscribe
    partial, message = if current_user
      venue = Venue.find(params[:id])
      user = current_user
      notification_reqs = user.notification_requests.where(:venue_id => venue.id)
      if notification_reqs.size > 0
        notification_reqs.destroy_all
        ['unsubscribe_success', 'Subscription cancelled']
      else
        ['unsubscribe_success', "Already unsubscribed!"]
      end
    else
      ['unsubscribe_error', 'Sign in to unsubscribe.']
    end

    respond_to do |format|
      format.js{ render partial, locals: {message: message} }
    end
  end

  def subscribed
    subscribed = if current_user
      venue = Venue.find(params[:id])
      user = current_user
      notification_reqs = user.notification_requests.where(:venue_id => venue.id)
      if notification_reqs.size > 0
        true
      else
        false
      end
    else
      false
    end

    respond_to do |format|
      format.json{ render json: {:subscribed => subscribed} }
    end
  end

  private

  def lat(l)
    l && l != 'undefined'
  end
end
