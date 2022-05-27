require 'rails_helper'

RSpec.describe 'home/home.html.erb', type: :system do
  before(:each) do
    User.create(name: 'Ally', email: 'ally@recipe.com', password: '11111111')
  end

  after(:each) do
    User.destroy_all
  end

  it 'I can see the title of the page and the sign in link.' do
    visit root_path
    expect(page).to have_content 'Forteresse'
    expect(page).to have_content 'LOG IN'
  end

  it 'I can not access this pages if user is connected' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'
  end
end
