module Api::V1
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      @user = resource_class.find_by_email(resource_params[:email])

      if @user and valid_params? and @user.valid_password?(resource_params[:password])
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @user.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @user.save

        json_response_success @user, UserSerializer
      elsif @user
        json_response_fail errors: [
            "A confirmation email was sent to your account at #{@user.email}. "+
            "You must follow the instructions in the email before your account "+
            "can be activated"
          ], status: 401
      else
        json_response_fail errors: ["Invalid login credentials. Please try again."], status: 401
      end
    end

    def valid_params?
      params[:password] && params[:email]
    end
  end
end
