class CreateFyles < ActiveRecord::Migration[5.0]
  def change
    create_table :fyles do |t|
      t.string :path, null: false
      t.integer :folder_id, null: false
      t.integer :num_pages
      t.text :thumb_dimensions
      t.timestamps null: false
    end

    create_table :folders do |t|
      t.string :path, null: false
      t.integer :parent_folder_id
      t.timestamps null: false
    end
  end
end
