class AddPinnedToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :pinned, :boolean
  end
end
