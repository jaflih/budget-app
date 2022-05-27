require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /home ' do
    let(:user) { create(:user) }

    it 'and user not logged returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
