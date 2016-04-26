class AddSlugToPodcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :slug, :text, null: :false
    add_index :podcasts, :slug, unique: true
  end
end
