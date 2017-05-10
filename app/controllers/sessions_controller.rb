class SessionsController < ApplicationController
	# include helper :cart

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user && User.authenticate(params[:email], params[:password])
			session[:user_id] = user.id
			#my_cart = Cart.new
			session[:cart] ||= Hash.new
			#session[:cart] = 
			# create_cart;
			redirect_to home_path, notice: "Logged in!"
		else
			flash.now.alert = "Email or password is invalid"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to home_path, notice: "Logged out!"
	end
end
