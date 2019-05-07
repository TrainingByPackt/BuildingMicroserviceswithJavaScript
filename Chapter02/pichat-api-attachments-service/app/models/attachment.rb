class Attachment < ApplicationRecord
  belongs_to :message
  validates_presence_of :url, :media_type, :file_name
end
