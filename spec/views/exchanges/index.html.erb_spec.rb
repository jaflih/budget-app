require 'rails_helper'

RSpec.describe 'categories/1/exchanges', type: :system do
  before(:each) do
    ally = User.create(name: 'Ally', email: 'ally@recipe.com', password: '11111111')
    bob = User.create(name: 'Bob', email: 'bob@recipe.com', password: '11111111')
    @cat1 = Category.create(name: 'Category_1', icon: 'https://cdn-icons-png.flaticon.com/512/6969/6969002.png',
                            user: ally)
    Category.create(name: 'Category_2', icon: 'https://cdn-icons-png.flaticon.com/512/6969/6969002.png', user: ally)
    @cat3 = Category.create(name: 'Category_3', icon: 'icon_3', user: bob)

    @ex1 = Exchange.create(name: 'transaction 1', amount: '20', author: ally)
    @ex1.categories << @cat1
    @ex2 = Exchange.create(name: 'transaction 2', amount: '19.99', author: ally)
    @ex2.categories << @cat1

    @ex3 = Exchange.create(name: 'transaction 3', amount: '50.0', author: bob)
    @ex3.categories << @cat3
  end

  after(:each) do
    User.destroy_all
  end

  it 'I can not access this page if user is not connected.' do
    visit category_exchanges_path @cat1
    expect(page).to_not have_content 'CATEGORIES'
    expect(page).to have_content 'Email'
  end

  it 'I can access this page if user is connected' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit category_exchanges_path @cat1
    expect(page).to have_content 'All transaction for'
    expect(page).to have_content @cat1.name
  end

  it 'I can logout form the catagories page' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit category_exchanges_path @cat1
    expect(page).to have_content 'All transaction for'

    click_button 'X'

    expect(page).to have_content 'Forteresse'
    expect(page).to_not have_content 'CATEGORIES'
  end

  it 'I can see all exchange for a categorie ' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit category_exchanges_path @cat1
    expect(page).to have_content 'All transaction for'

    expect(page).to have_content @ex1.name
    expect(page).to have_content @ex2.name
  end

  it 'I can not acces category form another user ' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit category_exchanges_path @cat3
    expect(page).to_not have_content 'All transaction for'
    expect(page).to have_content 'CATEGORIES'
  end

  it 'I can see the total price for the specific  categories ' do
    visit new_user_session_path
    fill_in 'user_email',	with: 'ally@recipe.com'
    fill_in 'user_password',	with: '11111111'
    click_button 'Log in'

    expect(page).to_not have_content 'Forteresse'
    expect(page).to have_content 'CATEGORIES'

    visit category_exchanges_path @cat1
    expect(page).to have_content 'All transaction for'

    expect(page).to have_content '39.99$'
  end
end
