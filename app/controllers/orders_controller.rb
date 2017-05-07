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
			session[:order_id] = @order.id
			#@item = @item_price.item
			redirect_to order_path(@order), notice: "Changed the price of #{@order.date}."
		else
			render action: 'new'
		end
	end
	
	def show
		@order_items = @order.order_items.all
	end

	private
	def order_params
		params.require(:order).permit(:order_id, :date, :school_id, :user_id, :grand_total, :payment_receipt)
	end


end
