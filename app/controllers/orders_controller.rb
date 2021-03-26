class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @order=Order.new
  end
  
  def create
    @order = Order.new
    binding.pry
    if @order.valid?
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order).permit(:item_id, :user_id).merge(item_id: @item.id, user_id: current_user.id)
  end

end
