module Calculations
  class Monthly
    attr_reader :venue, :months_before

    def initialize(venue, months_before = 1)
      @venue = venue
      @months_before = months_before
    end

    def charity_names
      @charity_names ||= Charity.all.map(&:name)
    end

    def total_purchases_by_charities
      @total_purchases_by_charities ||= get_total_purchases_by_charities
    end

    def human_readable_summary
      total_purchases_by_charities.map{|charity_name, total_purchase| "#{total_purchase} kids through #{charity_name}"}.to_sentence
    end

    def month
      start_date.strftime "%B"
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
          :group_name => reservation_or_payment.user.name,
          :num_diners => reservation_or_payment.num_diners.to_i,
          :date => reservation_or_payment.created_at,
          :offer_name => reservation_or_payment.offer.name,
          :price => reservation_or_payment.num_diners.to_i * venue.multiplier.to_f
        }
        data[:coupon] = if reservation_or_payment.is_a? Reservation
          reservation_or_payment.coupon
        else
          reservation_or_payment.code
        end
        OpenStruct.new(data)
      end
    end

    private
    def get_reservations
      Reservation.where(created_at: start_date..end_date).where(venue_id: venue.id).includes(:user, :offer)
    end

    def get_payments
      Payment.where(created_at: start_date..end_date).joins(:offer).where("offers.venue_id = ?", venue.id).includes(:user, :offer)
    end

    def get_total_purchases_by_charities
      total_purchases = Reservation.where(venue_id: venue.id).
                  where(created_at: start_date..end_date).
                  joins(:charity).
                  group("charities.name").
                  count
      total_purchases.default = 0
      total_purchases
    end

    def start_date
      months_before.month.ago.beginning_of_month.to_date
    end

    def end_date
      months_before.month.ago.end_of_month.to_date
    end

    def pretty_date(date)
      date.to_formatted_s(:rfc822)
    end
  end
end
