module Api::V1
  class SessionsController < Devise::SessionsController
    before_action :load_user_authentication
    respond_to :json

    def create
      if @user.valid_password? user_params[:password]
        sign_in @user, store: false
        render json: {message: "Signed in successfully", user: @user, status: 200}
        return
      end

      render json: {message: "Sign in failed"}, status: 200
    end

    def destroy
      if @user.authentication_token == user_params[:authentication_token]
        sign_out @user
        render json: {message: "Signed out"}, status: 200
      else
        render json: {message: "Invalid token"}, status: 200
      end
    end

    # private
    def load_user_authentication
      puts user_params[:email]
      @user = User.find_by_email user_params[:email]
      # return login_invalid unless @user
    end

    def user_params
      params.require(:user).permit :email, :password, :authentication_token
    end

    # def login_invalid
    #   render json: {message: "Invalid login"}, status: 200
    # end
  end
end