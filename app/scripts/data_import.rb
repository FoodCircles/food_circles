class DataImport
  def self.add_ot
    loop do 
      s, e = '',''

      puts "What's the id of the offer\?"
      id = gets.chomp.downcase.split(' ').map{|a| a.to_i}

      puts "Day of week?"
      day = gets.chomp.downcase.split(' ')
      day.each_with_index do |d,i|
        day[i] = {:mon=>0,:tue=>1,:wed=>2,:thu=>3,:fri=>4,:sat=>5,:sun=>6}[d.to_sym]
      end
      
      puts "Start time?"
      s = gets.chomp.downcase while s.length != 4

      puts "End time?"
      e = gets.chomp.downcase while e.length != 4
      
      id.each do |i|
        day.each do |d|
          start = (((s[0,2].to_i + 5) * 60) + s[2,4].to_i) + (d * 1440)
          ennd = (((e[0,2].to_i + 5) * 60) + e[2,4].to_i) + (d * 1440)
          ot = OpenTime.create(:openable_type => "Offer", :openable_id => i, :start => start, :end => ennd)
          ot.save
          puts "added (id is #{ot.id})"
        end
      end
    end
  end
end
