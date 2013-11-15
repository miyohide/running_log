class RunlogsController < ApplicationController
   def index
      @runlogs = Runlog.order(:start_time)

      runlogs_year_group = @runlogs.group_by { |runlog| runlog.start_time.year }

      @chart = LazyHighCharts::HighChart.new("Runlogs") do |f|
         f.chart(type: "scatter")
         f.title(text: "Running log: distance v.s. pace")
         f.yAxis(max: 500)

         runlogs_year_group.keys.each do |year|
            year_data = runlogs_year_group[year].map do |runlog|
               [runlog.distance, self.class.helpers.pace(runlog.distance, runlog.duration)]
            end
            f.series(name: year.to_s, data: year_data)
         end
      end
   end
end
