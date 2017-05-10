class PurchasesController < ApplicationController
  authorize_resource
  
  def index
    @purchases = Purchase.chronological.to_a
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    
    if @purchase.save
      respond_to do |format|
      # format.html { redirect_to @purchase, notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}." }
      # format.json { render action: 'index', status: :created, location: @purchase }
      # format.js { render action: 'index', status: :created, location: @purchase }
      format.html { redirect_to @purchase, notice: "Successfully added" }
      @purchases = Purchase.chronological.to_a
      # format.js { render action: 'index', status: :created, location: @purchase }
      format.js
    end
  else
      # render action: 'new'
      format.html { render action: 'new' }
      format.json { render json: @purchases.errors, status: :unprocessable_entity }
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end
  
end