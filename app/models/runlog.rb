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

   def self.runlog_scatter_chart
      LazyHighCharts::HighChart.new("Runlogs") do |f|
         f.chart(type: "scatter")
         f.title(text: "Running log : distance v.s. pace")
         f.xAxis(title: { text: 'distance(km)'})
         f.yAxis(max: 500, title: { text: 'pace(seconds/km)'})
         f.legend(layout: 'vertical',
                  align: 'right',
                  verticalAligh: 'top',x: -100, y: -250,
                  floating: true)

         distance_vs_pace = Runlog.distance_vs_pace
         distance_vs_pace.keys.each do |year|
            f.series(name: year.to_s, data: distance_vs_pace[year])
         end
      end

   end
end
