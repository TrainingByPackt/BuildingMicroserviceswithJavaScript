require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:media_type) }
  it { should validate_presence_of(:file_name) }

end
