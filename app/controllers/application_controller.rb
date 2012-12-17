class ApplicationController < ActionController::Base
  protect_from_forgery
 	
  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end 

  def after_sign_out_path_for(resource_or_scope)
   request.referrer
  end
end
