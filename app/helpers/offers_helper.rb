module OffersHelper
  def min_deals(group)
    
    str = "(add $"
    if group == 4
      str << "1"
    elsif group == 6
      str << "2"
    else
      return ""
    end
    str << ")"
    str
  end
end
