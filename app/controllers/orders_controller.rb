class OrdersController < ApplicationController

	authorize_resource

	def index
		@active_orders = Order.chronological.to_a
	end

	def new
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		@item_price.start_date = Date.current
		if @item_price.save
			@item = @item_price.item
			redirect_to item_path(@item), notice: "Changed the price of #{@item.name}."
		else
			render action: 'new'
		end
	end

	private
	def order_params
		params.require(:item_price).permit(:item_id, :price, :category)
	end


end
