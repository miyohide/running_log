module RunlogsHelper
   def duration_to_seconds(duration)
      duration.to_f / 1000
   end

   def duration_to_hms(duration)
      Time.at(duration_to_seconds(duration)).gmtime.strftime("%R:%S")
   end

   def pace(distance, duration)
      duration_to_seconds(duration)/distance
   end
end
