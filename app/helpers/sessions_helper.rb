module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= warden.authenticate(scope: :user)
  end

  def current_user? user
    user == current_user
  end

  def logged_in?
    current_user.present?
  end
end
