class AddAumniauthToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string, default: ''
  end
end