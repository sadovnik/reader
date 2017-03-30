module SessionsHelper
  def current_user
    return nil unless session.key?(:user_id)
    @current_user ||= User.find(session[:user_id])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def authorize!
    flash.notice = 'Opps. Seems like we forgot who you are. Could you please remind us?'
    redirect_to root_path unless logged_in?
  end
end
