class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_id, only: [:index, :create]

  def index
    @order = CardInfo.new
    if current_user == @item.user || @item.order != nil
      redirect_to root_path
    end
  end

  def create
    @order = CardInfo.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
    render 'index'
    end
  end

  private

  def order_params
    params.require(:card_info).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item_id
    @item = Item.find(params[:item_id])
  end

end
