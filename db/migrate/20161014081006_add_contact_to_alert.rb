class AddContactToAlert < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :contact, :string
  end
end
