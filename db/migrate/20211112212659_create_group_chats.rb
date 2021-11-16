class CreateGroupChats < ActiveRecord::Migration[5.2]
  def change
    create_table :group_chats do |t|
      t.text :text
      t.timestamps
      
      t.references :group, index: true, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
