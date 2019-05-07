require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:messages) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:display_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
end
