class ApplicationController < ActionController::Base
	# protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  
  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.where(id: auth_token[:user_id] , organization_id: auth_token[:organization_id]).first
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :contact_no, :dob, :organization_id, :auth_token, :avatar])
  end

  private

  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    p "------ #{auth_token[:user_id]}"
    p "------ #{auth_token[:organization_id]}"
    http_token && auth_token && auth_token[:user_id].to_i && auth_token[:organization_id].to_i
  end 
end
