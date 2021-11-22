class CreateTagTable < ActiveRecord::Migration[5.2]
  # self.primary_key = :tag_name
  def change
    create_table :tags, primary_key: :name, id: false do |t|
      # t.string :user_id
      t.string :name, primary_key: true
      t.integer :freq, default: 0

    end
  end
end
