require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#index' do
    before do
      get :index
    end

    it 'renders http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    context 'when the attributes are valid' do
      before do
        post :create, params: { order: attributes_for(:order) }
      end

      it 'renders http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders notice created' do
        expect(json['notice']).to eq 'Created'
      end

      it 'save the new order in database' do
        expect do
          post :create, params: { order: attributes_for(:order) }
        end.to change(Order, :count).by(1)
      end
    end

    context 'when the attributes are invalid' do
      context 'with invalid amount' do
        it 'renders errors' do
          post :create, params: { order: attributes_for(:order, amount: nil) }

          expect(json['errors']['amount'])
            .to match_array(["can't be blank", 'is not a number'])
        end

        it_behaves_like 'invalid order attributes', :amount
      end

      context 'with invalid first_name' do
        it 'renders errors' do
          post :create,
            params: { order: attributes_for(:order, first_name: nil) }

          expect(json['errors']['first_name'])
            .to match_array(["can't be blank",
                             'Only one word containing more than two letters'])
        end

        it_behaves_like 'invalid order attributes', :first_name
      end

      context 'with invalid last_name' do
        it 'renders errors' do
          post :create,
            params: { order: attributes_for(:order, last_name: nil) }

          expect(json['errors']['last_name'])
            .to match_array(["can't be blank",
                             'Only one word containing more than two letters'])
        end

        it_behaves_like 'invalid order attributes', :last_name
      end

      context 'with invalid email' do
        it 'renders errors' do
          post :create, params: { order: attributes_for(:order, email: nil) }
          expect(json['errors']['email'])
            .to match_array(["can't be blank", 'is invalid'])
        end

        it_behaves_like 'invalid order attributes', :email
      end
    end
  end
end
