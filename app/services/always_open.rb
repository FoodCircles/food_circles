module AlwaysOpen
  def ensure_always_open
    self.open_times << OpenTime.new(start: 1, end: 7.days/60 )
  end
end
