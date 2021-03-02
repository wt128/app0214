class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :email, :users, unique: true
  end
end
