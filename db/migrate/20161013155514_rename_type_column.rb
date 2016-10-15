class RenameTypeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :alerts, :type, :alert_type
  end
end
