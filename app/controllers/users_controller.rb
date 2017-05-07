class UsersController < ApplicationController

	def new
		@user = User.new
        #@user.schools.build
	end

	def create
		@user = User.new(user_params)
		if @user.save
    		# if saved to database
    		session[:user_id] = @user.id
    		flash[:notice] = "Changed the user params #{@user.name}."
    		#@item = @item_price.item
    		#redirect_to item_path(@item_price.item) #items_path #@item_price.item.items_path # go to show item page
    		redirect_to home_path
    	else
    		# return to the 'new' form
    		render action: 'new'
    	end
    end

    def show
        @user = current_user
        # @school = School.
        @unshipped_orders = Order.not_shipped.where(user_id = @user.id)
        @past_orders = Order.all.where(user_id = @user.id)
    end

    def edit
    	@user = current_user
    end

    def update
    	if @user.update_attributes(user_params)
    		flash[:notice] = "Successfully updated #{@user.name}."
    		redirect_to (@user)
    	else
    		render action: 'edit'
    	end
    end


    def view_employees
        @employees = User.employees.paginate(:page => params[:page]).per_page(10)
    end

    def view_customers
        @customers = User.customers.paginate(:page => params[:page]).per_page(10)
    end

    private

    def set_user
    	@user = User.find(params[:id])
    end

    def user_params
    	params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :active)
    end 



end
