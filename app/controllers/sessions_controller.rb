class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(valid_params[:email])
                .try(:authenticate, valid_params[:password])

    if @user
      sign_in(@user)
      redirect_to registration_path(@user)
    else
      flash.now[:alert] = t('.unauthenticated')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to home_path
  end

  private

  def valid_params
    params.require(:user)
          .permit(:email, :password)
  end
end
