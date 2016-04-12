class AddRecordingToPodcast < ActiveRecord::Migration[5.0]
  def self.up
    change_table :podcasts do |t|
      t.attachment :recording
    end
  end

  def self.down
    remove_attachment :podcasts, :recording
  end
end
