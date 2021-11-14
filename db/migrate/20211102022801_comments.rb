class Comments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :is_public
      t.timestamp :created_at

      t.references :post, index: true, foreign_key: true
      t.references :from_user, foreign_key: {to_table: :users}
      t.references :to_comment, foreign_key: {to_table: :comments}
      
      
    end
  end
end
