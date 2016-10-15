class AddStatusToAlert < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :status, :string
  end
end
