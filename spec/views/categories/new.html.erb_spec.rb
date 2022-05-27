require 'rails_helper'

RSpec.describe 'categories/index', type: :system do
  before(:each) do
    User.create(name: 'Ally', email: 'ally@recipe.com', password: '11111111')
  end

  after(:each) do
    User.destroy_all
  end

  it 'I can not access this page if user is not connected.' do
    visit new_category_path
    expect(page).to_not have_content '<'
    expect(page).to_not have_content 'New category'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  it 'I can access this page if user is connected' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to have_content 'CATEGORIES'

    visit new_category_path

    expect(page).to have_content '<'
    expect(page).to have_content 'Create new category'
    expect(page).to_not have_content 'LOG IN'
  end

  it 'I can logout form the nes categories page' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit new_category_path

    click_button 'X'

    expect(page).to have_content 'Forteresse'
    expect(page).to_not have_content 'CATEGORIES'
  end

  it 'I can create a new  category' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit new_category_path

    fill_in 'category_name',	with: 'My category'
    fill_in 'category_icon',	with: 'https://cdn-icons-png.flaticon.com/512/175/175061.png'
    click_button 'Create Category'

    expect(page).to have_content 'CATEGORIES'
    expect(page).to have_content 'My category'
  end
end
