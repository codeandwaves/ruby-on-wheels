class ApplicationController < ActionController::API
  # required for authenticate_or_request_with_http_token
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user

  def secret
    "supers3cr3t"
  end

  private

  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  def authenticate_user
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

          @current_user_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end
end
