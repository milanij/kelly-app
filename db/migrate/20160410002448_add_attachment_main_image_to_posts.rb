class AddAttachmentMainImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :main_image
    end
  end

  def self.down
    remove_attachment :posts, :main_image
  end
end
