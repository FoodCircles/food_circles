namespace :vouchers do
  desc "Notifies users about vouchers expiring soon"
  task :check_expiring_soon => :environment do
    expiring_date = Rails.cache.read("expiring_soon")

    if expiring_date.nil? || expiring_date < Time.now.to_date then
      ExpiringSoonChecker.new.check
      Rails.cache.write("expiring_soon", Time.now.to_date)
    end
  end
end