require 'test_helper'

describe Runlog do
   describe ".group_by_year" do
      before do
         @last_year_run = Runlog.create(start_time: Time.now - 1.year)
         @this_year_run = Runlog.create(start_time: Time.now)
         @next_year_run = Runlog.create(start_time: Time.now + 1.year)
      end

      subject { Runlog.group_by_year }

      it "年がキーとなっていること" do
         subject.keys.must_include Time.now.year
         subject.keys.must_include (Time.now - 1.year).year
         subject.keys.must_include (Time.now + 1.year).year
      end

      it "年ごとのデータが正しいこと" do
         subject[Time.now.year].must_include @this_year_run
         subject[(Time.now - 1.year).year].must_include @last_year_run
         subject[(Time.now + 1.year).year].must_include @next_year_run
      end
   end

   describe ".distance_vs_pace" do
      before do
         @last_year_run = Runlog.create(start_time: Time.now - 1.year, distance: 1, duration: 1000)
         @this_year_run1 = Runlog.create(start_time: Time.now, distance: 2, duration: 1000)
         @this_year_run2 = Runlog.create(start_time: Time.now, distance: 10, duration: 2_000)
      end
      subject { Runlog.distance_vs_pace }

      it "前年のデータが正しいこと" do
         subject[(Time.now - 1.year).year].must_equal([[1.0, 1.0]])
      end

      it "今年のデータが正しいこと" do
         subject[Time.now.year].must_equal([[2.0, 0.5], [10.0, 0.2]])
      end
   end


end
