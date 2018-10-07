require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#index' do
    let!(:order) do
      create(:order, email: 'sobaka@gavgaka.ua', last_name: 'Willson')
    end
    let!(:orders) { create_list(:order, 3) }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when present email as filter param' do
      before do
        get :index, params: { filter: { email: '%@gmail.com' } }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns filtered orders if there is filter by email' do
        expect(assigns(:orders)).to match_array(orders)
      end
    end

    context 'when present last_name as filter param' do
      before do
        get :index, params: { filter: { last_name: '_now' } }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns filtered orders if there is filter by last_name' do
        expect(assigns(:orders)).to match_array(orders)
      end
    end

    context 'when present email and last_name as filter param' do
      before do
        get :index, params: { filter: { email: 'sobaka%', last_name: '%ills' } }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns filtered orders if there are filter by email and last_name' do
        expect(assigns(:orders)).to match_array(order)
      end
    end
  end

  describe '#create' do
    context 'when the attributes are valid' do
      before do
        post :create, params: { order: attributes_for(:order) }
      end

      it 'returns http success' do
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
