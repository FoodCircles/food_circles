namespace :vouchers do
  desc "Notifies users about vouchers expiring soon"
  task :check_expiring_soon => :environment do
    ExpiringSoonChecker.new.check
  end
end