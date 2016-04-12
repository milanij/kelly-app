class ChangePodcastsDateToReleaseDate < ActiveRecord::Migration[5.0]
  def up
    rename_column :podcasts, :date, :release_date
  end

  def down
    rename_column :podcasts, :release_date, :date
  end
end
