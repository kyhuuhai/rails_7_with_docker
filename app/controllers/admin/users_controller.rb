class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all.page(params[:page]).limit(Settings.page_limit)

    render json: @users
  end
end
