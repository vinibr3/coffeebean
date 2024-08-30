class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    redirect_to registration_path(current_user) and return if signed_in?

    redirect_to new_registration_path
  end
end
