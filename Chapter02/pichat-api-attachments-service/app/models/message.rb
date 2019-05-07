class Message < ApplicationRecord
  belongs_to :user
  belongs_to :from_user, class_name: "User"

  has_many :attachments
end
