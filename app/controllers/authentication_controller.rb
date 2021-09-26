class AuthenticationController < ApiController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      json_response({
                      user:
                      {
                        id: user.id,
                        email: user.email,
                        token: JsonWebToken.encode(sub: user.id)
                      }
                    }, :created)
    else
      json_response({ message: 'Wrong Email or password' }, :unauthorized)
    end
  end

  def fetch
    render json: current_user
  end
end
