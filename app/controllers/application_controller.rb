class ApplicationController < ActionController::Base
  include AuthenticationsHelper

  before_action :authenticate_user!

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def authenticate_user!
    redirect_to new_session_path unless signed_in?
  end
end
