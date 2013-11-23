class RunlogsController < ApplicationController
   def index
      @runlogs = Runlog.order(:start_time)

      runlogs_year_group = Runlog.group_by_year

      @chart = Runlog.runlog_scatter_chart

      @chart2 = LazyHighCharts::HighChart.new("column") do |f|
         f.chart(type: "column")
         f.title(text: "ランニングログ 月別走行距離")
         f.xAxis(categories: [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul',
                               'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ])
         f.yAxis(min: 0)
         runlogs_year = @runlogs.group_by { |runlog| runlog.start_time.year }
         runlogs_year.keys.each do |year|
            runlogs_month_group = runlogs_year[year].group_by { |runlog_year| runlog_year.start_time.month }
            year_data = Array.new(12) { 0 }
            runlogs_month_group.keys.each do |month|
               year_data[month - 1] = runlogs_month_group[month].sum(&:distance)
            end

            f.series(name: year.to_s, data: year_data)
         end
         f.options[:chart][:defaultSeriesType] = 'column'
         f.plot_options({column: { pointPadding: 0.1, borderWidth: 0 }})
      end
   end
end
