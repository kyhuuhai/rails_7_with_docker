module Session
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
    render json: { message: 'Please log in' }, status: :unauthorized and return unless decoded_token

    data = decoded_token.first

    @user ||= User.find_by_id(data["user_id"])
    is_expired = data["expired_time"].to_datetime <= Time.zone.now

    if is_expired || !@user
      raise ActiveRecord::RecordNotFound
    end

    @user
  end

  def require_user
    return if current_user

    render json: { message: 'Please log in' }, status: :unauthorized
  end
end
