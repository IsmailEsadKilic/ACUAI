class AddLikesToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :likes, :integer
  end
end
