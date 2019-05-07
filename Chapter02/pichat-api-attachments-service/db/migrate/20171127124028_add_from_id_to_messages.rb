class AddFromIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :from_user, references: :users, foreign_key: true
    add_foreign_key :messages, :users, column: :from_user_id
  end
end
