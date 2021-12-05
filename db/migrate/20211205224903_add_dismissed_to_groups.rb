class AddDismissedToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :dismissed, :boolean, default: false
  end
end
