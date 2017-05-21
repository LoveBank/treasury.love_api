class AddLinkedUserIdToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :linked_user_id, :id
  end
end
