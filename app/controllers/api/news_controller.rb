class Api::NewsController < ApplicationController
  def show
    render :json => {:error => true, :description => "Not Implemented"}, status: 503 and return
  end
end
