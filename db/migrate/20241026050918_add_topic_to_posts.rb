class AddTopicToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :topic, null: true, foreign_key: true
  end
end
