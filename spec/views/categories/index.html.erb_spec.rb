require 'rails_helper'

RSpec.describe 'categories/index', type: :system do
  before(:each) do
    ally = User.create(name: 'Ally', email: 'ally@recipe.com', password: '11111111')
    bob = User.create(name: 'Bob', email: 'bob@recipe.com', password: '11111111')
    cat1 = Category.create(name: 'Category_1', icon: 'https://cdn-icons-png.flaticon.com/512/175/175061.png',
                           user: ally)
    Category.create(name: 'Category_2', icon: 'https://cdn-icons-png.flaticon.com/512/6969/6969002.png', user: ally)
    Category.create(name: 'Category_3', icon: 'https://cdn-icons-png.flaticon.com/512/6968/6968996.png', user: bob)

    ex1 = Exchange.create(name: 'transaction 1', amount: '20', author: ally)
    ex1.categories << cat1
    ex2 = Exchange.create(name: 'transaction 2', amount: '19.99', author: ally)
    ex2.categories << cat1
  end

  after(:each) do
    User.destroy_all
  end

  it 'I can not access this page if user is not connected.' do
    visit categories_path
    expect(page).to_not have_content 'CATEGORIES'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  it 'I can access this page if user is connected' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'
  end

  it 'I can logout form the catagories page' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    click_button 'X'

    expect(page).to have_content 'Forteresse'
    expect(page).to_not have_content 'CATEGORIES'
  end

  it 'I can see all categories from the user logged and can not see the categories from another user' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    expect(page).to have_content 'Category_1'
    expect(page).to have_content 'Category_2'
    expect(page).to_not have_content 'Category_3'
  end

  it 'I can see the total price for each user categories logged' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    expect(page).to have_content 'Category_1'
    expect(page).to have_content '39.99$'
  end
end
