class Offer < ActiveRecord::Base
  belongs_to :venue
  has_many :open_times, :as => :openable, :dependent => :destroy

  def as_json(options={})
    { :id => self.id,
      :title => self.name,
      :details => self.details,
      :minimum_diners => self.min_diners,
      :times => self.open_times
    }
  end

  def self.currently_available(time=Time.now)
    t = ((time - time.beginning_of_week) / 60) + 300
    self.joins(:open_times).
      where("? BETWEEN open_times.start AND open_times.end", t).
      uniq
  end

  def self.not_available
    t = ((Time.now - Time.now.beginning_of_week) / 60) + 300
    day_end = ((Time.now.end_of_day - Time.now.beginning_of_week) / 60) + 300
    self.joins(:open_times).
      where("open_times.start BETWEEN :now AND :day_end", {now: t, day_end: day_end}).
      uniq
  end

end
