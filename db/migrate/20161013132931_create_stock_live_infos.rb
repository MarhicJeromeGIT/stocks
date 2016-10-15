class CreateStockLiveInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_live_infos do |t|
      t.decimal :value_now, :precision => 8, :scale => 3
      t.decimal :value_open, :precision => 8, :scale => 3
      t.decimal :value_high, :precision => 8, :scale => 3
      t.decimal :value_low, :precision => 8, :scale => 3
      t.decimal :variation_now, :precision => 8, :scale => 3
      t.decimal :variation_year, :precision => 8, :scale => 3
      t.integer :volume
      t.integer :traded_amount
      t.decimal :exchanged_capi, :precision => 8, :scale => 2
      t.datetime :date
      t.references :stock
      
      t.timestamps
    end
  end
end