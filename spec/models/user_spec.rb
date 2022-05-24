require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'test@test.com', password: 'helloWORLD', name: 'test') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without if name length is more than 30 characters' do
    subject.name = 'a' * 40
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should have_many(:categories) }
  end
end
