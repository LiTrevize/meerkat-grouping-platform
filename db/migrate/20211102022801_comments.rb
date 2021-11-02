class Comments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.int :comment_id
      t.string :content
      t.boolean :is_public
      t.timestamp :created_at

      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

    end
  end
end
