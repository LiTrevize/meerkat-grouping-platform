class CreatePostUserNicknames < ActiveRecord::Migration[5.2]
  def change
    create_table :post_user_nicknames do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :nickname_id, null: false
    end
  end
end
