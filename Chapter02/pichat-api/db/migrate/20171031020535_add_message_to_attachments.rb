class AddMessageToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_reference :attachments, :message, foreign_key: true
  end
end
