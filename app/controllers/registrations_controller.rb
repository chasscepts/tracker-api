class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.new(sign_up_params)
    if @user.save
      render json: @user
    else
      json_response({ message: 'Email has already been taken' }, :unauthorized)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
