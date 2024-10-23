class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= Author.find(session[:author_id]) if session[:author_id]
  end

  def logged_in?
    !!current_user
  end
end
