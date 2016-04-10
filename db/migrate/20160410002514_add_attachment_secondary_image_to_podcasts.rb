class AddAttachmentSecondaryImageToPodcasts < ActiveRecord::Migration
  def self.up
    change_table :podcasts do |t|
      t.attachment :secondary_image
    end
  end

  def self.down
    remove_attachment :podcasts, :secondary_image
  end
end
