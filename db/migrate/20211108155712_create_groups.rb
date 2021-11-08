class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.timestamps

      t.references :post, index: true, foreign_key: true
    end
  end
end
