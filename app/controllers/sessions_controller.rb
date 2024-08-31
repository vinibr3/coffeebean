class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.all_from_cache[valid_params[:email]]

    if @user && @user.authenticate(valid_params[:password])
      sign_in(@user)
      redirect_to registration_path(id: 1)
    else
      flash.now[:alert] = t('.unauthenticated')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end

  private

  def valid_params
    params.require(:user)
          .permit(:email, :password)
  end
end
