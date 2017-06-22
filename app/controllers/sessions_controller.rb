class SessionsController < ApplicationController
  def new
  end

  def create

    # @user (instance variable) rather than user (normal variable) - so we can access user for integration test using assigns(:user)

  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
  		# Login user
  		log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
  		redirect_to @user
  	else
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
