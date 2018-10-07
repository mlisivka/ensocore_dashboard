class OrdersController < ApplicationController
  def index
    if params[:filter]
      @orders = Order.filter(params[:filter])
    else
      @orders = Order.all
    end
  end

  def create
    order = Order.new(order_params)
    if order.save
      render json: { notice: 'Created' }
    else
      render json: { errors: order.errors }, status: 400
    end
  end

  private

  def order_params
    params.require(:order).permit(:email, :first_name, :last_name, :amount)
  end
end
