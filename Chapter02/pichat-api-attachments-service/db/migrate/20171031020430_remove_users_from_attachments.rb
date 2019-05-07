class RemoveUsersFromAttachments < ActiveRecord::Migration[5.1]
  def change
    remove_reference :attachments, :user, foreign_key: true
  end
end
