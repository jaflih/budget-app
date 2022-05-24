require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { described_class.new(name: 'Clothes', icon: 'C') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an icon' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if name length is more than 30 characters' do
    subject.name = 'a' * 40
    expect(subject).to_not be_valid
  end

  it 'is not valid if icon length is more than 20 characters' do
    subject.icon = 'i' * 40
    expect(subject).to_not be_valid
  end
end
