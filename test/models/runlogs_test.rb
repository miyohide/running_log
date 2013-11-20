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
      # TODO 年をキーに、値を距離とペースの配列としたHashを返す

   end


end
