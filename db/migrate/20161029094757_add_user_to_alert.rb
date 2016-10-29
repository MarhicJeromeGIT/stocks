class AddUserToAlert < ActiveRecord::Migration[5.0]
  def change
    add_reference :alerts, :user
  end
end
