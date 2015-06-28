module Calculations
  class All
    attr_reader :venue

    def initialize(venue)
      @venue = venue
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
      Reservation.where(venue_id: venue.id).includes(:user, :offer)
    end

    def get_payments
      Payment.joins(:offer).where("offers.venue_id = ?", venue.id).includes(:user, :offer)
    end

paids = Payment.joins(:offer).joins(:charity).group("charities.name").sum("payments.amount")
    def get_total_purchases_by_charities
      paids = Payment.joins(:offer).
              joins(:charity).
              where("offers.venue_id = ?", venue.id).
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
              group("charities.name").
              count
    end

    def get_total_reservations_by_charities
      Reservation.where(venue_id: venue.id).
                  joins(:charity).
                  group("charities.name").
                  count
    end
  end
end
