namespace :mailers do
  desc "Sends the badges for users who paid more than the minimun"
  task :daily_badges => :environment do
    calculations = Calculations::Achievements.new
    best_donors = calculations.best_donors
    badge = Badge.find_by_code('paidmore')

    best_donors.each do |bd|
      unless UserBadge.find_by_user_id(bd.id)
        @ubadge = UserBadge.new() 
        @ubadge.user = bd
        @ubadge.badge = badge
        @ubadge.sent_email = false
        @ubadge.save
      end
    end

    send_emails = UserBadge.find_all_by_sent_email(false)

    send_emails.each do |se|
      UserMailer.badge_email(se.user.email, badge.category, badge.title).deliver
      se.sent_email = true
      se.save
    end


  end
end