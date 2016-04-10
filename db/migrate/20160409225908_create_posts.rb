class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.datetime :date
      t.text :description
      t.text :title
      t.boolean :visible
      t.timestamps
    end
  end
end
