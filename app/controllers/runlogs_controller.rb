class RunlogsController < ApplicationController
   def index
      @runlogs = Runlog.order(:start_time).all
   end
end
