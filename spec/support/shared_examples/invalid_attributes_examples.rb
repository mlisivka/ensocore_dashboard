RSpec.shared_examples 'invalid order attributes' do |attribute|
  it 'returns http bad request' do
    post :create, params: { order: attributes_for(:order, attribute => nil) }
    expect(response).to have_http_status(:bad_request)
  end

  it 'does not save the new order in database' do
    expect do
      post :create,
        params: { order: attributes_for(:order, attribute => nil) }
    end.not_to change(Order, :count)
  end
end
