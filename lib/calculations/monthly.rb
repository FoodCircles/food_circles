module Calculations
  class Monthly
    attr_reader :venue, :pdate

    def initialize(venue, pdate)
      @venue = venue
      @date = pdate

      date_split = pdate.split('_')

      if date_split.length == 2 then
        @pmonth = date_split[0].to_i
        @pyear = date_split[1].to_i
      end
    end

    def charity_names
      @charity_names ||= total_purchases_by_charities.map{|charity_id, total_purchase| Charity.find(charity_id).name}
    end

    def charity_ids
      @charity_ids ||= total_purchases_by_charities.map{|charity_id, total_purchase| charity_id}
    end

    def total_purchases_by_charities
      @total_purchases_by_charities ||= get_total_purchases_by_charities
    end

    def human_readable_summary
      total_purchases_by_charities.map{|charity_id, total_purchase| Charity.find(charity_id).msg_usefunds(total_purchase.round)}.to_sentence
    end

    def date
      @date
    end

    def month
      start_date.strftime "%B"
    end

    def link_date
      start_date.strftime "%m_%Y"
    end

    def pretty_start_date
      pretty_date(start_date)
    end

    def pretty_end_date
      pretty_date(end_date)
    end

    def payments
      (get_reservations + get_payments).map do |reservation_or_payment|
        data = {
          :group_name => reservation_or_payment.user.email,
          :date => reservation_or_payment.created_at,
          :offer_name => reservation_or_payment.offer.name
        }
        if reservation_or_payment.is_a? Reservation
          data.merge!({
            :coupon => reservation_or_payment.coupon,
            :num_diners => reservation_or_payment.num_diners.to_i
          })
        else
          data.merge!({
            :coupon => reservation_or_payment.code,
            :num_diners => reservation_or_payment.offer.min_diners.to_i
          })
        end
        payment = OpenStruct.new(data)
        payment.price = payment.num_diners * venue.multiplier.to_f
        payment
      end
    end

    private
    def get_reservations
      Reservation.where(created_at: start_date..end_date).where(venue_id: venue.id).includes(:user, :offer)
    end

    def get_payments
      Payment.where(created_at: start_date..end_date).joins(:offer).where("offers.venue_id = ?", venue.id).includes(:user, :offer)
    end

paids = Payment.joins(:offer).joins(:charity).group("charities.name").sum("payments.amount")
    def get_total_purchases_by_charities
      paids = Payment.joins(:offer).
              joins(:charity).
              where("offers.venue_id = ?", venue.id).
              where(created_at: start_date..end_date).
              group("charities.id").
              sum("payments.amount")
      paids.each do |charity, val|
        if val.nil?
          paids[charity] = 0
        end
      end
      return paids
    end

    def get_total_payments_by_charitites
      Payment.joins(:offer).
              joins(:charity).
              where("offers.venue_id = ?", venue.id).
              where(created_at: start_date..end_date).
              group("charities.name").
              count
    end

    def get_total_reservations_by_charities
      Reservation.where(venue_id: venue.id).
                  where(created_at: start_date..end_date).
                  joins(:charity).
                  group("charities.name").
                  count
    end

    def start_date
      DateTime.new(@pyear, @pmonth, 1).to_date
    end

    def end_date
      DateTime.new(@pyear, @pmonth, 1).end_of_month.to_date
    end

    def pretty_date(date)
      date.to_formatted_s(:rfc822)
    end

  end
end
