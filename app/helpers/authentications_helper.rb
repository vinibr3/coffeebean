module AuthenticationsHelper
  def sign_in(user)
    session[:user_email] = user.email
  end

  def current_user
    @current_user ||= User.all_from_cache[session[:user_email]] if session[:user_email]
  end

  def sign_out
    session[:user_email] = nil
    @current_user = nil
  end

  def signed_in?
    current_user.present?
  end
end
