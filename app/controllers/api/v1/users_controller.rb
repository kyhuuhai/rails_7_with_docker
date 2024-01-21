module Api::V1
  class UsersController < ApplicationController
    # before_action :authenticate_user_by_token!

    respond_to :json

    def index
      @users = User.all

      render json: @users
    end
  end
end
