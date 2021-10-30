class CreateProfilesTable < ActiveRecord::Migration[5.2]
  def up
    create_table :profiles do |t|
      t.string :school
      t.string :degree
      t.string :major
      t.references :user, index: true, foreign_key: true
    end
  end

  def down
    drop_table :profiles
  end
end
