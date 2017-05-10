class OrderItemsController < ApplicationController

	before_action :set_order_item

	# def create
	# 	@order = current_order
	# 	@order_item = @order.order_items.new(order_item_params)
	# 	@order.save
	# 	session[:order_id] = @order.id
	# end

	# def update
	# 	@order = current_order
	# 	@order_item = @order.order_items.find(params[:id])
	# 	@order_item.update_attributes(order_item_params)
	# 	@order_items = @order.order_items
	# end

	# def destroy
	# 	@order = current_order
	# 	@order_item = @order.order_items.find(params[:id])
	# 	@order_item.destroy
	# 	@order_items = @order.order_items
	# end


	def edit


	end 



	def update
		if @order_item.update(order_item_params)
			redirect_to order_path(@order_item.order), notice: "Successfully updated #{@item.name}."
		else
			render action: 'edit'
		end
	end


	def complete_order_item

    # set completed and completed_by fields
    @order_item.shipped_on = Date.current
    # @task.completed_by = current_user.id

    if @order_item.save!
    	flash[:notice] = 'Order Item marked as shipped'
      # if params[:status] == "task_details"
      #   redirect_to task_path(@task)
      # else
      redirect_to home_path
      # end
  else
  	render :action => "edit"
  end

end 


private

def set_order_item
	@order_item = OrderItem.find(params[:id])
end

def order_item_params
	params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
end
end

