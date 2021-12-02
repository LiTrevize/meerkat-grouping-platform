class AddReferenceToPostTags < ActiveRecord::Migration[5.2]
  def change
    add_column :post_tags, :tag_name, :string
    add_foreign_key :post_tags, :tags, column: :tag_name, primary_key: :name
    add_index :post_tags, :tag_name
  end
end
