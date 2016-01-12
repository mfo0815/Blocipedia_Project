class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ##Custom
      t.string :name

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable


      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
  class AddConfirmableToDevise < ActiveRecord::Migration
    # Note: You can't use change, as User.update_all will fail in the down migration
    def up
      add_column :users, :confirmation_token, :string
      add_column :users, :confirmed_at, :datetime
      add_column :users, :confirmation_sent_at, :datetime
      # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
      add_index :users, :confirmation_token, unique: true
      # User.reset_column_information # Need for some types of updates, but not for update_all.
      # To avoid a short time window between running the migration and updating all existing
      # users as confirmed, do the following
      execute("UPDATE users SET confirmed_at = NOW()")
      # All existing user accounts should be able to log in after this.
      # Remind: Rails using SQLite as default. And SQLite has no such function :NOW.
      # Use :date('now') instead of :NOW when using SQLite.
      # => execute("UPDATE users SET confirmed_at = date('now')")
      # Or => User.all.update_all confirmed_at: Time.now
    end

    def down
      remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
      # remove_columns :users, :unconfirmed_email # Only if using reconfirmable
    end
  end
end
