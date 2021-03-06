require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :total }
    it { is_expected.to validate_presence_of :status }
  end

  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end
end
