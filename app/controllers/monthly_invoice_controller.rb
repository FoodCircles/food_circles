class MonthlyInvoiceController < ApplicationController

  def monthly_invoice

    @vid = params[:vid].to_i
    months_before = params[:months_before].to_i
    @months_before = months_before
    sql = "select date_trunc('month', current_date - INTERVAL '#{months_before} month') as start_date, date_trunc('month', current_date - INTERVAL '#{months_before} month')+'1month'::interval-'1day'::interval as end_date;"
    @previous_month_dates = Reservation.find_by_sql(sql)
    start_date = @previous_month_dates[0][:start_date]
    end_date = @previous_month_dates[0][:end_date]
    @s = start_date
    @e = end_date

    #@reserve_venues have all data remember it.
    @reserve_venues = Reservation.where("created_at >= :start_date AND created_at <= :end_date AND venue_id = :vid",
                                        {:start_date => start_date, :end_date => end_date,:vid => params[:vid].to_i })
    find_venue = "select name,id,address,multiplier from venues where id IN(#{params[:vid].to_i})"
    @venue_names = Venue.find_by_sql(find_venue)

    gr_kids ="select count(charity_id) as gr_kids from reservations where charity_id ='1' AND venue_id = #{params[:vid].to_i} AND created_at >= '#{@s}' AND created_at <= '#{@e}'"
    world_kids ="select count(charity_id) as world_kids from reservations where charity_id ='2' AND venue_id = #{params[:vid].to_i} AND created_at >= '#{@s}' AND created_at <= '#{@e}' "

    @gr_kids = Reservation.find_by_sql(gr_kids)
    @world_kids=Reservation.find_by_sql(world_kids)
    puts ""
  end

  def new_layout

    #@vid = params[:vid].to_i
    #months_before = params[:months_before].to_i
    #@months_before = months_before
    #sql = "select date_trunc('month', current_date - INTERVAL '#{months_before} month') as start_date, date_trunc('month', current_date - INTERVAL '#{months_before} month')+'1month'::interval-'1day'::interval as end_date;"
    #@previous_month_dates = Reservation.find_by_sql(sql)
    #start_date = @previous_month_dates[0][:start_date]
    #end_date = @previous_month_dates[0][:end_date]
    #@s = start_date
    #@e = end_date
    #
    ##@reserve_venues have all data remember it.
    #@reserve_venues = Reservation.where("created_at >= :start_date AND created_at <= :end_date AND venue_id = :vid",
    #                                    {:start_date => start_date, :end_date => end_date,:vid => params[:vid].to_i })
    #find_venue = "select name,id,address,multiplier from venues where id IN(#{params[:vid].to_i})"
    #@venue_names = Venue.find_by_sql(find_venue)
    #
    #gr_kids ="select count(charity_id) as gr_kids from reservations where charity_id ='1' AND venue_id = #{params[:vid].to_i} AND created_at >= '#{@s}' AND created_at <= '#{@e}'"
    #world_kids ="select count(charity_id) as world_kids from reservations where charity_id ='2' AND venue_id = #{params[:vid].to_i} AND created_at >= '#{@s}' AND created_at <= '#{@e}' "
    #
    #@gr_kids = Reservation.find_by_sql(gr_kids)
    #@world_kids=Reservation.find_by_sql(world_kids)
    #puts ""

    generate_invoice();
  end
  def custom_invoice

    generate_invoice();
    #please add route and view

  end
end
