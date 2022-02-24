class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :purchased_item, only: [:index, :create]
  
  def index
    @item = Item.find(params[:item_id])
    @purchase_destination = PurchaseDestination.new
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    @item = Item.find(params[:item_id])
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_destination).permit(:post_code, :prefecture_id, :city, :building_name, :address, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end

  def purchased_item
    # itemがあっての、order_form（入れ子構造）。他のコントローラーで生成されたitemを使うにはcreateアクションに定義する。
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase.present?
  end
end
