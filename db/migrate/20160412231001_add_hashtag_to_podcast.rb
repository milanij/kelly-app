class AddHashtagToPodcast < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :hashtag, :text
  end
end
