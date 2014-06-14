namespace :mailers do
  desc "Sends the monthy invoice"
  task :monthly_invoice, [:months_ago] => [:environment] do |t, args|
    
    unless args[:months_ago].nil? then
      Venue.find_each do |venue|
        UserMailer.monthly_invoice(venue, args[:months_ago].to_i).deliver
      end
    end

    args.with_defaults(:months_ago => 1)

  end
end
