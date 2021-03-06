require 'rails_helper'

RSpec.describe Entry, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:linked_user_id) }
end
