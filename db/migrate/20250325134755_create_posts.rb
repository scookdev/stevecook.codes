class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :summary
      t.string :status
      t.string :slug
      t.string :tags

      t.timestamps
    end
  end
end
