class CartsController < ApplicationController

	#include ChessStoreHelpers::Cart


	def new
		session[:cart] ||= Hash.new
    redirect_to root_path
	end

	def clear
		session[:cart] = Hash.new
	end

	def add_item
    if session[:cart].keys.include?(params[:id])
      # if item in cart, increment quantity by 1
      session[:cart][params[:id]] += 1
    else
      # add it to the cart
      session[:cart][params[:id]] = 1
    end
    redirect_to "/items"
  end


  def remove_item
    if session[:cart].keys.include?(params[:id])
      session[:cart].delete(params[:id])
    end
    redirect_to "/carts/" + params[:id]
  end

  def index
    # @order_items = get_list_of_items_in_cart
    #@order = session[:order_id]
    @order_items = Array.new
    return @order_items if session[:cart].empty? # skip if cart empty...
    session[:cart].each do |item_id, quantity|
     info = {item_id: item_id, quantity: quantity}
     @order_item = OrderItem.new(info)
     @order_items << @order_item
   end
   @order_items 
 end

 def show
  @order_items = Array.new
  return @order_items if session[:cart].empty? # skip if cart empty...
  session[:cart].each do |item_id, quantity|
    info = {item_id: item_id, quantity: quantity}
    @order_item = OrderItem.new(info)
    @order_items << @order_item
  end
  #@order_items 
  #@grand_total = grand_total()
  @total = 0
  return total if session[:cart].empty? # skip if cart empty...
  session[:cart].each do |item_id, quantity|
    info = {item_id: item_id, quantity: quantity}
    order_item = OrderItem.new(info)
    @total += order_item.subtotal
  end
  # @total
end

def checkout
  @order = Order.new
  session[:cart].each do |item_id, quantity|
    info = {item_id: item_id, quantity: quantity, order_id: @order.id}
    OrderItem.create(info)
  end
  redirect_to "/orders/" + @order.id
end

# def destroy
#   session[:cart] = nil
# end




def grand_total
  total = 0
  return total if session[:cart].empty? # skip if cart empty...
  session[:cart].each do |item_id, quantity|
    info = {item_id: item_id, quantity: quantity}
    order_item = OrderItem.new(info)
    total += order_item.subtotal
  end
  total
end 




end
