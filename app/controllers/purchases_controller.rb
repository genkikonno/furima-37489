class PurchasesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @item = Item.find(params[:item_id])
    @purchase_destination = PurchaseDestination.new
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    @item = Item.find(params[:item_id])
    if @purchase_destination.valid?
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
end
