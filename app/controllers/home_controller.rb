class HomeController < ApplicationController
  def home
    @items_to_reorder = Item.all.need_reorder.alphabetical.to_a
    @pending_orders = Order.all.not_shipped
    # .chronological.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end