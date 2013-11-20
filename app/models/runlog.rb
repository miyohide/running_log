class Runlog < ActiveRecord::Base
   def self.group_by_year
      Runlog.order(:start_time).group_by { |runlog| runlog.start_time.year }
   end
end
