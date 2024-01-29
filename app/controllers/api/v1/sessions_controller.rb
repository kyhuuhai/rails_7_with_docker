module Api::V1
  class SessionsController < ApiController
    def create
      @user = User.find_by_email(params[:email])

      if @user and valid_params? and @user.valid_password?(params[:password])
        token = encode_token({
          user_id: @user.id,
          expired_time: Time.zone.now + 1.hour
        })

        json_response_success @user, UserSerializer, {token: token}
      else
        json_response_fail errors: ["Invalid login credentials. Please try again."], status: 401
      end
    end

    def valid_params?
      params[:password] && params[:email]
    end
  end
end
