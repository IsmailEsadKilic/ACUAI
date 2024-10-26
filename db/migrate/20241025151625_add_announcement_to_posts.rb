class AddAnnouncementToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :announcement, :boolean
  end
end
