class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    enable_extension "pgcrypto"

    create_table :posts, id: :uuid do |t|
      t.string :title
      t.text :body
      t.string :featured_image
      t.string :status

      t.timestamps
    end
  end
end
