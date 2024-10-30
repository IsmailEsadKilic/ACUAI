class AddViewsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :views, :integer
  end
end
