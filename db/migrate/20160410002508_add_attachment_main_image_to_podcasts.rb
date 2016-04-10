class AddAttachmentMainImageToPodcasts < ActiveRecord::Migration
  def self.up
    change_table :podcasts do |t|
      t.attachment :main_image
    end
  end

  def self.down
    remove_attachment :podcasts, :main_image
  end
end
