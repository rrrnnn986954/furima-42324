class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold_out, only: [:index, :create] # 追加

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      @order_address.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  # 売り切れガード
  def redirect_if_sold_out
    return unless @item.sold_out?

    redirect_to item_path(@item), alert: 'この商品はすでに売り切れています'
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :street, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id)
  end
end
