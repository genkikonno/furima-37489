class ItemsController < ApplicationController
  
  def index
    #@item = Item.all
  end

  def new
    before_action :authenticate_user!
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :delivery_charge_id, :prefecture_id,
                                 :delivery_date_id, :price, :image).merge(user_id: current_user.id)
  end
end
