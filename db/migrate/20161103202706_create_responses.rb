class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.text :body, null: false
      t.boolean :handled, null: false, default: false, index: true
      t.references :seat, foreign_key: true

      t.timestamps
    end
  end
end
