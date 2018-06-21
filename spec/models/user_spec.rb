require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end
  it 'is invalid without username' do
    expect(FactoryBot.build(:user, username: nil)).not_to be_valid
  end
  it 'is invalid without email' do
    expect(FactoryBot.build(:user, email: nil)).not_to be_valid
  end
  it "returns a contact's full name as a string"
end
