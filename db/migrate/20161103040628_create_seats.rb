class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :team, null: false, foreign_key: true

      t.timestamps

      t.index [:team_id, :email], unique: true
    end
  end
end
