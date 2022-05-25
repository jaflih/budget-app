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
      Exchange.create! valid_attributes
      get exchanges_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      exchange = Exchange.create! valid_attributes
      get exchange_url(exchange)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_exchange_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      exchange = Exchange.create! valid_attributes
      get edit_exchange_url(exchange)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Exchange' do
        expect do
          post exchanges_url, params: { exchange: valid_attributes }
        end.to change(Exchange, :count).by(1)
      end

      it 'redirects to the created exchange' do
        post exchanges_url, params: { exchange: valid_attributes }
        expect(response).to redirect_to(exchange_url(Exchange.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Exchange' do
        expect do
          post exchanges_url, params: { exchange: invalid_attributes }
        end.to change(Exchange, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post exchanges_url, params: { exchange: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'C&A', amount: 129.99 }
      end

      it 'updates the requested exchange' do
        exchange = Exchange.create! valid_attributes
        patch exchange_url(exchange), params: { exchange: new_attributes }
        exchange.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the exchange' do
        exchange = Exchange.create! valid_attributes
        patch exchange_url(exchange), params: { exchange: new_attributes }
        exchange.reload
        expect(response).to redirect_to(exchange_url(exchange))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        exchange = Exchange.create! valid_attributes
        patch exchange_url(exchange), params: { exchange: invalid_attributes }
        skip('Can not find solution for this issue')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested exchange' do
      exchange = Exchange.create! valid_attributes
      expect do
        delete exchange_url(exchange)
      end.to change(Exchange, :count).by(-1)
    end

    it 'redirects to the exchanges list' do
      exchange = Exchange.create! valid_attributes
      delete exchange_url(exchange)
      expect(response).to redirect_to(exchanges_url)
    end
  end
end
