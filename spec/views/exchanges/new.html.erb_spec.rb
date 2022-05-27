require 'rails_helper'

RSpec.describe 'categories/1/exchanges/new', type: :system do
  before(:each) do
    ally = User.create(name: 'Ally', email: 'ally@recipe.com', password: '11111111')
    @cat1 = Category.create(name: 'Category_1', icon: 'https://cdn-icons-png.flaticon.com/512/6968/6968996.png',
                            user: ally)
  end

  after(:each) do
    User.destroy_all
  end

  it 'I can not access this page if user is not connected.' do
    visit new_category_exchange_path @cat1
    expect(page).to_not have_content '<'
    expect(page).to_not have_content 'New exchange'
    expect(page).to have_content 'Email'
  end

  it 'I can access this page if user is connected' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to have_content 'CATEGORIES'

    visit new_category_exchange_path @cat1

    expect(page).to have_content '<'
    expect(page).to have_content 'Create new exchange'
    expect(page).to_not have_content 'Email'
  end

  it 'I can logout form the nes categories page' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit new_category_exchange_path @cat1

    click_button 'X'

    expect(page).to have_content 'Forteresse'
    expect(page).to_not have_content 'CATEGORIES'
  end

  it 'I can create a new  exchange' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit new_category_exchange_path @cat1

    fill_in 'exchange_name',	with: 'My exchange'
    fill_in 'exchange_amount',	with: 12.8
    click_button 'Create Exchange'

    expect(page).to have_content 'All transaction for'
    expect(page).to have_content 'My exchange'
    expect(page).to have_content '12.8'
  end
end
