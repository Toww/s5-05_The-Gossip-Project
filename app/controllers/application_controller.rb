class ApplicationController < ActionController::Base

	include SessionHelper






	private

	def authenticate_user
		unless current_user
			flash[:error] = "Please log in."
			redirect_to session_new_path
		end
	end

end
