class Api::V1::AuthController < ApplicationController

  def login
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      token = user.generate_jwt
      render json: { user: user, token: token }
    else
      render json: { errors: { message: 'Email or password is invalid' } }, status: :unauthorized
    end
  end

  def persist
    # user = User.last
    # render json: { "user" => user.to_json }
    if request.headers['Authorization']
      token = request.headers['Authorization'].split(" ")[1]
      jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

      user_id = jwt_payload['id']
      user = User.find(user_id)
      render json: { "user" => user.to_json }
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
