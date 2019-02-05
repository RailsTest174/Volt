class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :user, null: false
      t.datetime :published_at, null: false, index: true

      t.timestamps
    end
  end
end
