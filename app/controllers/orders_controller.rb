class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      pay_item # Payjpで決済
      @order_address.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  rescue Payjp::CardError => e
    flash[:alert] = "決済に失敗しました: #{e.message}"
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    render :index, status: :unprocessable_entity
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
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :secret_key)
    Payjp::Charge.create(
      amount: @item.amount,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
