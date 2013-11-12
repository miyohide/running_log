class CreateRunlogs < ActiveRecord::Migration
  def change
    create_table :runlogs do |t|
      t.time :start_time
      t.float :distance
      t.integer :duration
      t.float :pace

      t.timestamps
    end
  end
end
