class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root_path
  before_action :sold_out
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_purchase = OrderPurchase.new
  end

  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_purchase = OrderPurchase.new(order_params)
    if @order_purchase.valid?
      pay_item
      @order_purchase.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_purchase).permit(:post_code, :prefecture_id, :city, :street_address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def move_to_root_path
    redirect_to root_path if current_user.id == @item.user.id
  end

  def sold_out
    if @item.order.present?
      redirect_to root_path
    end
  end


end
