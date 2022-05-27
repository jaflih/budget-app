require 'rails_helper'

RSpec.describe '/exchanges', type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  let(:valid_attributes) do
    { name: 'C&A', amount: 29.99, author_id: user.id }
  end

  let(:invalid_attributes) do
    { name: 'C&A' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      cat1 = Category.create(name: 'Category_1', icon: 'icon_1', user_id: user.id)
      ex1 = Exchange.create! valid_attributes
      cat1.exchanges << ex1
      get category_exchanges_path cat1
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      cat1 = Category.create(name: 'Category_1', icon: 'icon_1', user_id: user.id)

      get new_category_exchange_path cat1
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'redirects to the created exchange' do
        cat1 = Category.create(name: 'Category_1', icon: 'icon_1', user_id: user.id)

        post category_exchanges_path cat1, params: { exchange: valid_attributes }
        expect(response).to redirect_to(category_exchanges_path(cat1))
      end
    end
  end
end

RSpec.describe '/exchanges and user not logged', type: :request do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    { name: 'C&A', amount: 29.99, author_id: user.id }
  end

  let(:invalid_attributes) do
    { name: 'C&A' }
  end

  describe 'GET /index' do
    it 'redirects to the login page' do
      cat1 = Category.create(name: 'Category_1', icon: 'icon_1', user_id: user.id)

      Exchange.create! valid_attributes
      get category_exchanges_path cat1
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /new' do
    it 'redirects to the login page' do
      cat1 = Category.create(name: 'Category_1', icon: 'icon_1',
                             user_id: user.id)

      get new_category_exchange_path cat1
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'redirects to the login page' do
        cat1 = Category.create(name: 'Category_1', icon: 'icon_1',
                               user_id: user.id)

        expect do
          post category_exchanges_path cat1,
                                       params: { exchange: valid_attributes }
        end.to change(Exchange, :count).by(0)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'redirects to the login page' do
        cat1 = Category.create(name: 'Category_1',
                               icon: 'icon_1', user_id: user.id)

        post category_exchanges_path cat1,
                                     params: { exchange: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
