class UsersController < ApplicationController

 before_filter :require_login, :only => [:create_profile, :add]
	# GET /user/add
  # GET /user/add.json
  def add
    @user = current_user
    unless current_user.user_info.blank? 
      current_user.user_info.each do | key , value|
        m = "#{key}="
        unless key.to_str == "avatar" 
          @user.send( m, current_user.user_info[key] ) if @user.respond_to?( m )
        end
      end
    end
    respond_to do |format|
      format.html # add.html.erb
      format.json { render json: @user }
    end
  end

  def create_profile    
    @user = current_user
    if @user.update_attributes(params[:user])
      params[:user].delete("avatar")# deleting avtar from user
      @user.user_info = params[:user]
      @user.save!
      flash[:notice] = "You have successfully saved"
      redirect_to users_add_profile_path
    else
      flash[:notice] = "Something went wrong"
      render :action => :add 
    end        
  end

end
