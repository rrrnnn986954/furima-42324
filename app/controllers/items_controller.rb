class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_name, :item_explanation, :category_id, :situation_id,
                                 :shipping_charge_id, :shipping_area_id, :delivery_time_id,
                                 :amount, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path unless current_user == @item.user
  end
end
