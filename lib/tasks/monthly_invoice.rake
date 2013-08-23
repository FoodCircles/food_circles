namespace :mailers do
  desc "Sents the monthy invoice"
  task :monthly_invoice => :environment do
    # Suggested crontab entry
    # 0 0 12 1 1/1 ? *  cd [path to application folder] && [path to rake binary] mailers:monthly_invoice RAILS_ENV=[rails env]
    # Cron entry for staging:
    # 0 0 12 1 1/1 ? *  cd /home/tkxel_dev/staging/staging && bundle exec rake mailers:monthly_invoice RAILS_ENV=staging

    Venue.find_each do |venue|
      UserMailer.monthly_invoice(venue).deliver
    end
  end
end
