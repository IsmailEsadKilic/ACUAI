class AddNotifiableToNotifications < ActiveRecord::Migration[7.1]
  def up
    # First add the columns as nullable
    add_reference :notifications, :notifiable, polymorphic: true, null: true

    # Update existing records if needed
    execute <<-SQL
      UPDATE notifications 
      SET notifiable_type = 'Post', 
          notifiable_id = (SELECT id FROM posts LIMIT 1)
      WHERE notifiable_type IS NULL
    SQL

    # Then make the columns non-nullable
    change_column_null :notifications, :notifiable_type, false
    change_column_null :notifications, :notifiable_id, false
  end

  def down
    remove_reference :notifications, :notifiable, polymorphic: true
  end
end
