require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#create' do
    context 'when the data are valid' do
      before do
        post :create, params: { order: attributes_for(:order) }
      end

      it 'render http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'render notice created' do
        expect(json['notice']).to eq 'Created'
      end
    end

    context 'when the data are invalid' do
      before do
        post :create, params: { order: attributes_for(:order, amount: nil) }
      end

      it 'render http bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'render errors' do
        expect(json['errors']['amount']).
          to match_array(["can't be blank", 'is not a number'])
      end
    end
  end
end
