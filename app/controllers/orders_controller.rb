class OrdersController < ApplicationController
  before_action :set_item, only: :index
  def index
    
    
  end
  def create
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

end
