class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.string :type
      t.references :stock
      t.decimal :target_value, :precision => 8, :scale => 3
      t.timestamps
    end
  end
end
