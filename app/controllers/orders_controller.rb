class OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]

	authorize_resource

	def index
		@active_orders = Order.chronological.to_a
	end

	def new
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		add_from_cart(@order)
		assert(false)
		respond_to do |format|
			if @order.save
				# Cart.destroy(session[:cart_id])
				session[:cart_id] = nil
				format.html {redirect_to items_path, notice: 'Thank you for your order.' }
				format.json { render action: 'show', status: :created,location: @order }
			#@item = @item_price.item
			# redirect_to order_path(@order), notice: "Changed the price of #{@order.date}."
		else
			format.html { render action: 'new' }
			format.json { render json: @order.errors,
				status: :unprocessable_entity }
			end
			# redirect_to "/orders/" + self.id
		end
	end

	def show
		@order_items = @order.order_items.unshipped.all
	end

	def edit

	end


	def update
		if @order.update(order_params)
			redirect_to order_path(@order), notice: "Successfully updated order."
		else
			render action: 'edit'
		end
	end

	def add_from_cart(order)
		session[:cart].each do |item_id, quantity|
			info = {item_id: item_id, quantity: quantity, order_id: order.id}
			OrderItem.create(info)
		end
		# redirect_to "/orders/" + @order.id
	end

	private
	def set_order
		@order = Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:order_id, :date, :school_id, :user_id, :grand_total, :payment_receipt)
	end


end
