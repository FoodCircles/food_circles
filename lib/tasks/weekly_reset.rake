namespace :vouchers do
  desc "Reset available vouchers and update total vouchers"
  task :reset => :environment do
    vouchers_total = 0
    Venue.all.each do |venue|
      if venue.vouchers_total.nil?
        venue.vouchers_total = 1
      end
      vouchers_total += venue.vouchers_total
    end

    total_collected = Payment.total_week_payments.collect{ |payment| payment.amount }.sum

    Venue.all.each do |venue|
      if total_collected < 3 * vouchers_total / 4 # missed meal goal
        if venue.vouchers_available > 0 and venue.vouchers_total > 1
          venue.vouchers_total -= 1
        end
      else
        if venue.vouchers_available == 0
          venue.vouchers_total += 1
        end
      end
      venue.vouchers_available = venue.vouchers_total
      venue.save
    end
  end
end
