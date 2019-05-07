class User < ApplicationRecord
  has_secure_password
  
  has_many :messages, :dependent => :destroy

  validates_presence_of(:username, :display_name, :email, :password_digest)
  validates_uniqueness_of(:username, :email)

  def sent_messages
    Message.where(from_user_id: id)
  end
end
