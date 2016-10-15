class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :code
      t.string :codif
      t.string :name
      t.string :place

      t.timestamps
    end
  end
end
