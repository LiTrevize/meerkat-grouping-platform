class CreateGroupUser < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.string :status
      t.references :group, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
