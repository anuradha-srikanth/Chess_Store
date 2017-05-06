class SchoolsController < ApplicationController



	private

	def school_params
		params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :active )
	end 
end
