class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:username], params[:password])
  	if user
  		session[:id] = user.id
  		redirect_to root_url
  	else
  		flash.now.alert = "Invalid username or password"
  		render "new"
  	end
  end

  def destroy
  	session[:id] = nil
  	redirect_to root_url
  end


end
