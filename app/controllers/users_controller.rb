class UsersController < ApplicationController
  
	# form to create new users
  def new
  	@user = User.new
  	render :new
  end

  # creates users in database
  def create
  	user = User.new(user_params)
  	if user.save
  		session[:user_id] = user.id
  		redirect_to profile_path
  	else
  		redirect_to signup_path
  	end
  end

  # shows current_user
  def show
  	render :show
  end

  private
  	def user_params
  		params.require(:user).permit(:username, :email, :password)
  	end
end
