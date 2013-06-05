class OffersController < ApplicationController
  def show
    @offer = Offer.find(params[:id])
    if ['json','jsonp'].include?(params[:format])
      render :json => @offer, :callback => params[:callback]
    end
  end

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def create
    @offer = Offer.new(params[:offer])
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Asset was successfully created.' }
        format.json { render json: @offer, status: :created, location: @offer }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end
end
