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
    unless logged_in?
      redirect_to root_path, notice: 'Seems like we forgot who you are. Could you please remind us?'
    end
  end
end
