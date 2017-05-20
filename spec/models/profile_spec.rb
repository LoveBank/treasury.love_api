require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should have_many(:entries).dependent(:destroy) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
end
