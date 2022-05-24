require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:seller) { User.create(name: 'Ally', email: 'test@test.com', password: '123456') }
  let(:category) { Category.create(name: 'Clothes', icon: 'C', user_id: seller.id) }
  let(:exchange) { Exchange.create(name: 'H&M', amount: 19.99, author_id: seller.id) }

  subject { described_class.new(category_id: category.id, exchange_id: exchange.id) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:category) }
    it { should belong_to(:exchange) }
  end
end
