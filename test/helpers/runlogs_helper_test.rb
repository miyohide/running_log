require 'test_helper'

describe RunlogsHelper do
   describe :duration_to_seconds do
      it { duration_to_seconds(1000).must_equal 1.0 }
   end

   describe :duration_to_hms do
      ## NOTE durationの計算。秒に変換して1,000倍したもの
      ##      1hour = { 1 * ( 60 * 60 ) + 0 * 60 + 0 } * 1_000 = 3_600_000
      ##      1min  = { 0 * ( 60 * 60 ) + 1 * 60 + 0 } * 1_000 =    60_000
      ##      1sec  = { 0 * ( 60 * 60 ) + 0 * 60 + 1 } * 1_000 =     1_000
      it { duration_to_hms(3_670_000).must_equal "01:01:10" }
   end
end
