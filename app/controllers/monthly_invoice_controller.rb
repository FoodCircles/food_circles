class MonthlyInvoiceController < ApplicationController
  def monthly_invoice
    venue = Venue.find(params[:vid].to_i)
    @calculations = Calculations::Monthly.new(venue, params[:months_before].to_i)
  end
end
