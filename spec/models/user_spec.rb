require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'test@test.com', password: 'helloWORLD') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end
  it 'is not valid without an password' do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end
end
