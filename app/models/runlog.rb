class Runlog < ActiveRecord::Base
   def self.group_by_year
      Runlog.order(:start_time).group_by { |runlog| runlog.start_time.year }
   end

   def self.distance_vs_pace
      group_by_year = Runlog.group_by_year
      distance_vs_pace = {}

      group_by_year.keys.each do |year|
         year_data = group_by_year[year].map { |runlog|
            [runlog.distance, runlog.pace]
         }

         distance_vs_pace.store(year, year_data)
      end

      distance_vs_pace
   end

   def pace
      ( duration.to_f / 1000 ) / distance
   end
end
