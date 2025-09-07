class OrdersController < ApplicationController
  before_action :authenticate_user!       # ログイン必須
  before_action :set_item                 # 購入対象の商品を取得

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

  # 購入対象の商品をセット
  def set_item
    @item = Item.find(params[:item_id])
  end

  # Strong Parameters
  def order_address_params
    params.require(:order_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :street,      # 住所の番地
      :building,    # 建物名
      :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: @item.id
    )
  end
end
