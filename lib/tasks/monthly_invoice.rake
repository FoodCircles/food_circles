namespace :mailers do
  desc "Sents the monthy invoice"
  task :monthly_invoice => :environment do
    # Suggested crontab entry
    # 0 0 12 1 1/1 ? *  cd [path to application folder]; RAILS_ENV = '[rails env]' [path to rake binary] mailers:monthly_invoice

    Venue.find_each do |venue|
      UserMailer.monthly_invoice(venue).deliver
    end
  end
end
