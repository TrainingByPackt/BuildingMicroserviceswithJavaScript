class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.integer :media_type
      t.string :file_name
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
