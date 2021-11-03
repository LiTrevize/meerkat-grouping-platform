class Posts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      # t.string :user_id
      t.string :title
      t.text :content
      t.timestamps

      t.references :user, index: true, foreign_key: true
    end
  end
end
