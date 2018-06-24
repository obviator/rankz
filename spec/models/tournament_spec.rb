require 'rails_helper'

describe Tournament do
  let(:tournament) { build(:tournament) }

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
end
