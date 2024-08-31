class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
     if signed_in?
       redirect_to registration_path(current_user)
     else
       redirect_to new_registration_path
     end
  end
end
