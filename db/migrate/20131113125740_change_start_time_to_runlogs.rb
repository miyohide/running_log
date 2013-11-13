class ChangeStartTimeToRunlogs < ActiveRecord::Migration
  def change
     change_column :runlogs, :start_time, :datetime
  end
end
