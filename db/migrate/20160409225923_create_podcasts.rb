class CreatePodcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.datetime :date
      t.text :description
      t.text :title
      t.boolean :visible
      t.timestamps
    end
  end
end
