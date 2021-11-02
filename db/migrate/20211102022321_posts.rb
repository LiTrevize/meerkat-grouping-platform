class Posts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.int :post_id
      # t.string :user_id
      t.string :title
      t.string :content
      t.timestamp :createdAt
      t.timestamp :updated_at

      t.references :user, index: true, foreign_key: true
    end
  end
end
