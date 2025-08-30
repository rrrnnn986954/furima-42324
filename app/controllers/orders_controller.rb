class OrdersController < ApplicationController
  def index
    return unless params[:item_id]

    @item = Item.find(params[:item_id])
  end
end
