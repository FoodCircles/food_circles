class SocialLink < ActiveRecord::Base
  belongs_to :venue

  def source
    case url
    when /www\.yelp\.(.+)/
      "yelp"
    when /www\.twitter\.(.+)/
      "twitter"
    else
      "facebook"
    end 
  end
end
