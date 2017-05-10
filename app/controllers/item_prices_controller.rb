class ItemPricesController < ApplicationController
  before_action :set_item_price, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    @active_items = Item.active.alphabetical.to_a
  end

  def new
    @item_price = ItemPrice.new
  end

  def create
    @item_price = ItemPrice.new(item_price_params)
    @item_price.start_date = Date.current
    @item = @item_price.item
    @price_history = @item_price.item.item_prices.all

    if @item_price.save
      respond_to do |format|
        @item = @item_price.item
        format.html { redirect_to item_path(@item), notice: "Changed the price of #{@item.name}."}
        format.js
      end
    else
      respond_to do |format|
      # render action: 'new'
      format.html { render action: 'new' }
      # format.json { render json: @item_price.errors, status: :unprocessable_entity }
      # format.js
    end 
  end

    # @item_price = ItemPrice.new(item_price_params)
    # @item_price.start_date = Date.current
    # if @item_price.save
    #   @item = @item_price.item
    #   redirect_to item_path(@item), notice: "Changed the price of #{@item.name}."
    # else
    #   render action: 'new'
    # end
  end

  private

  def set_item_price
    @item_price = ItemPrice.find(params[:id])
  end


  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end




end