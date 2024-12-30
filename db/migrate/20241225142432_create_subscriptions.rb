class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.integer :poster_id
      t.integer :subscriber_id

      t.timestamps
    end

    add_index :subscriptions, :poster_id
    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, [:poster_id, :subscriber_id], unique: true
  end
end
