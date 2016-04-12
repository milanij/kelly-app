class ChangePostsDateToPublishedDate < ActiveRecord::Migration[5.0]
  def up
    rename_column :posts, :date, :published_date
  end

  def down
    rename_column :posts, :published_date, :date
  end
end
