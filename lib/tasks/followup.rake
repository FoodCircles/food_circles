namespace :vouchers do
  desc "Follows up to users who made a purchase"
  task :check_follow_up => :environment do
    followup_date = Rails.cache.read("followup_date")

    if followup_date.nil? || followup_date < Time.now.to_date then
      FollowUpChecker.new.check
      Rails.cache.write("followup_date", Time.now.to_date)
    end
  end
end