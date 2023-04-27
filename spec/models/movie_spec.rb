require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:link) }
  end
end
