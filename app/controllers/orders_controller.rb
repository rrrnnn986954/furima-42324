class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # JSで使用
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold_out
    return unless @item.sold_out? || current_user == @item.user

    redirect_to root_path, alert: 'この商品は購入できません'
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :street, :building, :phone_number, :token
    ).merge(user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
