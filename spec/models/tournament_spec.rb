require 'rails_helper'

describe Tournament do
  let(:owner) { create(:owner) }
  let(:tournament) { create(:tournament, owner: owner) }

  describe 'factory' do
    it 'is valid' do
      expect(tournament).to be_valid
    end
  end

  describe '#end_date' do
    it 'may not exist' do
      tournament.end_date = nil
      expect(tournament).to be_valid
    end
    it 'is not before start_date' do
      tournament.end_date = (tournament.start_date - 1)
      expect(tournament).not_to be_valid
    end
    it 'is on or after start_date' do
      tournament.end_date = tournament.start_date
      expect(tournament).to be_valid
      tournament.end_date = tournament.start_date + 1
      expect(tournament).to be_valid
    end
  end

  describe '#start_date' do
    it 'exists' do
      tournament.start_date = nil
      expect(tournament).not_to be_valid
    end
    it 'is not before start_date' do
      tournament.end_date = (tournament.start_date - 1)
      expect(tournament).not_to be_valid
    end
    it 'is on or after start_date' do
      tournament.end_date = tournament.start_date
      expect(tournament).to be_valid
      tournament.end_date = tournament.start_date + 1
      expect(tournament).to be_valid
    end
  end
  describe '#name' do
    it 'exists' do
      tournament.name = nil
      expect(tournament).not_to be_valid
      tournament.name = ''
      expect(tournament).not_to be_valid
    end
    it 'is unique' do
      tournament.save
      expect(build(:tournament, slug: 'NewTournament')).not_to be_valid
    end
    it 'is correct length' do
      tournament.name = 'a' * 1
      expect(tournament).not_to be_valid
      tournament.name = 'a' * 21
      expect(tournament).not_to be_valid
      tournament.name = 'a' * 15
      expect(tournament).to be_valid
    end
  end
  describe '#slug' do
    it 'exists' do
      expect { tournament.update_column(:slug, nil) }.to raise_error(ActiveRecord::NotNullViolation)
    end
    it 'is not blank' do
      tournament.slug = ''
      expect(tournament).not_to be_valid
    end
    it 'is unique' do
      tournament.save
      expect(build(:tournament, name: 'NewTournament')).not_to be_valid
    end
    it 'is correct length' do
      tournament.name = 'a' * 1
      expect(tournament).not_to be_valid
      tournament.name = 'a' * 21
      expect(tournament).not_to be_valid
      tournament.name = 'a' * 15
      expect(tournament).to be_valid
    end
  end
  describe '#owner' do
    it 'returns owner' do
      expect(tournament.owner).to eq owner
    end
    it 'returns a user' do
      expect(tournament.owner).to respond_to(:has_role?)
      expect(tournament.owner.class.name).to eq 'User'
    end
  end
  describe '#owner=' do
    let(:owner2) { create(:owner) }
    it 'can set nil' do
      tournament.owner = nil
      expect(tournament).not_to be_valid
    end
    it 'can set new owner' do
      tournament.owner = owner2
      expect(tournament.owner).not_to eq owner
      expect(tournament.owner).to eq owner2
    end
  end
end
