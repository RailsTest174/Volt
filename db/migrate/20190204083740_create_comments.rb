class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.references :user, null: false
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end