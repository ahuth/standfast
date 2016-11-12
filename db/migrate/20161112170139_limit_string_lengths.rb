class LimitStringLengths < ActiveRecord::Migration[5.0]
  def up
    change_column :teams, :name, :string, limit: 255
    change_column :seats, :name, :string, limit: 255
    change_column :seats, :email, :string, limit: 255
  end

  def down
    change_column :seats, :email, :string, limit: nil
    change_column :seats, :name, :string, limit: nil
    change_column :teams, :name, :string, limit: nil
  end
end
