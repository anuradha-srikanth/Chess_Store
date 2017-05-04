class UsersController < ApplicationController


	def new
		@user = User.new
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

    private

    def set_user
    	@user = User.find(params[:id])
    end

    def user_params
    	params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :active)
    end 



end
