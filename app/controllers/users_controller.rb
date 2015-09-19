class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
	@user = User.new(user_params)
	if @user.save
	  flash[:notice] = "You signed up successfully"
	  flash[:color]= "valid"
	else
	  flash[:notice] = "Form is invalid"
	  flash[:color]= "invalid"
	end
	render "new"
  end

  def show
  	@user = User.find(params[:id])
  end

  def create_picture
		@picture = Picture.new(picture_params)
		@user = User.find(session[:id])
		@picture.user_id = @user.id
		if @picture.save
			redirect_to @user
		end
	end



  private

		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end

		def picture_params
			params.require(:picture).permit(:image)
		end

end
