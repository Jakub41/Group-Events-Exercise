class CreateGroupEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :group_events do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.integer :status, default: 0
      t.decimal :latitude, { precision: 10, scale: 6}
      t.decimal :longitude, { precision: 10, scale: 6}
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
