module Calculations
  class Monthly
    attr_reader :venue_id, :months_before

    def initialize(venue_id, months_before = 1)
      @venue_id = venue_id
      @months_before = months_before
    end

    def world_kids
      sql = "select count(charity_id) as world_kids from reservations where charity_id ='2' AND venue_id = #{venue_id} AND created_at >= '#{start_date}' AND created_at <= '#{end_date}' "
      Reservation.find_by_sql(sql)
    end

    def gr_kids
      sql = "select count(charity_id) as gr_kids from reservations where charity_id ='1' AND venue_id = #{venue_id} AND created_at >= '#{start_date}' AND created_at <= '#{end_date}' "
      Reservation.find_by_sql(sql)
    end

    def venue_names
      find_venue = "select name,id,address,multiplier from venues where id IN(#{venue_id})"
      Venue.find_by_sql(find_venue)
    end

    def reserve_venues
      Reservation.where("created_at >= :start_date AND created_at <= :end_date AND venue_id = :vid",
                                        {:start_date => start_date, :end_date => end_date, :vid => venue_id })
    end

    def start_date
      months_before.ago.beginning_of_month
    end

    def end_date
      months_before.ago.end_of_month
    end

    private
    def get_kids_by_charity_id(charity_id)
      sql = "select count(charity_id) as world_kids from reservations where charity_id ='#{charity_id}' AND venue_id = #{venue_id} AND created_at >= '#{start_date}' AND created_at <= '#{end_date}' "
      Reservation.find_by_sql(sql)
    end
  end
end
