class SchoolsController < ApplicationController


	def index
		@active_schools = School.active.alphabetical.to_a
	end

	def new
		@school = School.new
        #@user.schools.build
	end

	def create
		@school = School.new(school_params)
		if @user.save
    		# if saved to database
    		#session[:user_id] = @user.id
    		flash[:notice] = "Changed the school params #{@school.name}."
    		redirect_to school_path
    	else
    		# return to the 'new' form
    		render action: 'new'
    	end
    end

    # def edit
    # 	@user = current_user
    # end

    # def update
    # 	if @school.update_attributes(user_params)
    # 		flash[:notice] = "Successfully updated #{@user.name}."
    # 		redirect_to (@user)
    # 	else
    # 		render action: 'edit'
    # 	end
    # end


	private

	def school_params
		params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :active )
	end 
end
