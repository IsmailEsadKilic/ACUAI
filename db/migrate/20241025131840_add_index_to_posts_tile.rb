class AddIndexToPostsTile < ActiveRecord::Migration[7.2]
  def change
    add_index :posts, :title
  end
end
