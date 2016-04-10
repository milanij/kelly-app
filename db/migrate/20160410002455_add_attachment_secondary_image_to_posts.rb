class AddAttachmentSecondaryImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :secondary_image
    end
  end

  def self.down
    remove_attachment :posts, :secondary_image
  end
end
