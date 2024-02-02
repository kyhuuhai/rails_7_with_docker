module Api::V1
  class UsersController < ApiController
    before_action :require_user

    def index
      users = User.all

      json_response_success users, UserSerializer
    end

    def show
      user =User.find_by_id(params[:id])

      json_response_success user, UserSerializer
    end
  end
end
