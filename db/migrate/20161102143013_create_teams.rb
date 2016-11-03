class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :name], unique: true
    end
  end
end
