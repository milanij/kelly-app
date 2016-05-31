class AddFileSizeToPodcasts < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :file_size, :string
  end
end
