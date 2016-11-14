class AddAccounts < ActiveRecord::Migration[5.0]
  def up
    create_table :accounts do |t|
      t.boolean :disabled, null: false, default: false

      t.timestamps
    end

    add_reference :users, :account
    add_reference :teams, :account

    say_with_time "backfilling users and teams without accounts" do
      User.where(account_id: nil).find_each do |user|
        account = Account.create!
        user.update_column(:account_id, account.id)
        Team.where(user_id: user.id).update_all(account_id: account.id)
      end
    end

    change_column_null :users, :account_id, false
    change_column_null :teams, :account_id, false
    remove_reference :teams, :user

    add_index :teams, [:account_id, :name], unique: true
    add_foreign_key :teams, :accounts
    add_foreign_key :users, :accounts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
