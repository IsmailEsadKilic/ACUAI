class CreateUploadedFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :uploaded_files do |t|
      t.string :name

      t.timestamps
    end
  end
end