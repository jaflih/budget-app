require 'rails_helper'

RSpec.describe Exchange, type: :model do
  let(:seller) { User.create(name: 'Ally', email: 'test@test.com', password: '123456') }
  subject { described_class.new(name: 'H&M', amount: 19.99, author_id: seller.id) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an amount' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should belong_to(:author) }
    it { should have_many(:categories).through(:slots) }
  end
end
