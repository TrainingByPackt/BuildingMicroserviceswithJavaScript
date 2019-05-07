class RemoveAttachmentFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_reference :messages, :attachment, foreign_key: true
  end
end
