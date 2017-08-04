class HomeController < ApplicationController
  def home
    @boards = Item.active.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
    @pieces = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
    @clocks = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
    @supplies = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10)    
    # get a list of any inactive items for sidebar
    @inactive_items = Item.inactive.alphabetical.to_a
    @items_to_reorder = Item.all.need_reorder.alphabetical.to_a
    @pending_orders = Order.all.not_shipped
    # .chronological.to_a
    # render :controller => 'item', :action => 'index'
    render template: "items/index"
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end