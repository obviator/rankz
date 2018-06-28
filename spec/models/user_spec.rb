# frozen_string_literal: true

require 'rails_helper'

describe User do
  let!(:user) { create(:user) }
  describe 'factory' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end
  describe '#username' do
    it 'is present' do
      user.username = nil
      expect(user).not_to be_valid
      user.username = ''
      expect(user).not_to be_valid
    end
    it 'is unique' do
      expect(build(:user, email: user.email)).not_to be_valid
      expect(build(:user, email: user.username)).not_to be_valid
    end
    it 'is correct length' do
      user.username = 'a' * 2
      expect(user).not_to be_valid
      user.username = 'a' * 21
      expect(user).not_to be_valid
      user.username = 'a' * 15
      expect(user).to be_valid
    end
  end
  describe '#email' do
    it 'is present' do
      user.email = nil
      expect(user).not_to be_valid
    end
    it 'is unique' do
      expect(build(:user, username: user.username)).not_to be_valid
      expect(build(:user, username: user.email)).not_to be_valid
    end
  end
  describe 'roles' do
    it 'has default role' do
      expect(user.has_role? :coach).to be_truthy
      expect(user.roles.count == 1).to be_truthy
    end
    describe '#add_role' do
      it 'adds role' do
        user.add_role :admin
        expect(user.has_role?(:admin)).to be_truthy
      end
    end
  end
end
