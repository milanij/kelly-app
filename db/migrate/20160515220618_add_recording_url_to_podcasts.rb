class AddRecordingUrlToPodcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :recording_url, :text
  end
end
