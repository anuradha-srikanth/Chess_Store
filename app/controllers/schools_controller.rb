class SchoolsController < ApplicationController
    before_action :set_school, only: [:show, :edit, :update, :destroy]

    def index
      @active_schools = School.active.alphabetical.to_a
    end

    def show
        # @active_schools = School.active.alphabetical.to_a
    end

    def new
      @school = School.new
        #@user.schools.build
    end

    def create
      @school = School.new(school_params)
      if @school.save
    		# if saved to database
    		#session[:user_id] = @user.id
    		flash[:notice] = "Successfully added #{@school.name} to system."
    		redirect_to school_path(@school)
    	else
    		# return to the 'new' form
    		render action: 'new'
    	end
    end

    private
    def set_school
        @school = School.find(params[:id])
    end
    def school_params
      params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :active )
  end 
end
