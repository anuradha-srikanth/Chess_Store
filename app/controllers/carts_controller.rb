class CartsController < ApplicationController

	#include ChessStoreHelpers::Cart


	def new
		#@cart = ChessStoreHelpers::Cart.new
		#create_cart
		session[:cart] ||= Hash.new
	end

	def clear
		# clear_cart
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




  end
