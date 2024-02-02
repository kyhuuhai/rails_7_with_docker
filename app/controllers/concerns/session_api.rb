module SessionApi
  extend ActiveSupport::Concern

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRECT_TOKEN'])
  end

  def decoded_token
    header = request.headers['Authorization']

    return unless header

    token = header.split(" ")[1]

    begin
      JWT.decode(token, ENV['JWT_SECRECT_TOKEN'])
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    return nil unless decoded_token

    token_data = decoded_token.first

    @user ||= User.find_by_id(token_data["user_id"])
    is_expired = token_data["expired_time"].to_datetime <= Time.zone.now

    return nil if is_expired || !@user

    @user
  end

  def require_user
    return if current_user

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  # def user_signed_in?
  #   current_user.present?
  # end
end
