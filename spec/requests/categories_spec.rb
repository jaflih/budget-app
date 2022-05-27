require 'rails_helper'

RSpec.describe '/categories and user loggeg', type: :request do
  let(:user) { create(:user) }
  before { sign_in user }
  let(:valid_attributes) do
    { name: 'Hobby', icon: 'hobby', user_id: user.id }
  end

  let(:invalid_attributes) do
    { name: 'Hobby' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Category.create! valid_attributes
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post categories_url, params: { category: valid_attributes }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post categories_url, params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post categories_url, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

RSpec.describe '/categories and user not logged', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    { name: 'Hobby', icon: 'hobby', user_id: user.id }
  end

  let(:invalid_attributes) do
    { name: 'Hobby' }
  end

  describe 'GET /index' do
    it 'redirects to the login page' do
      Category.create! valid_attributes
      get categories_url
      expect(response).not_to be_successful
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /new' do
    it 'redirects to the login page' do
      get new_category_url
      expect(response).not_to be_successful
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST /create' do
    context 'redirects to the login page' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: { category: valid_attributes }
        end.to change(Category, :count).by(0)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'redirects to the login page' do
        post categories_url, params: { category: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
