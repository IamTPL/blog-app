class SessionsController < ApplicationController

  def new
  end 

  def create
    author = Author.find_by(email: params[:session][:email].downcase)
    if author && author.authenticate(params[:session][:password])
      session[:author_id] = author.id
      flash[:notice] = "Logged in successfully"
      redirect_to author
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end