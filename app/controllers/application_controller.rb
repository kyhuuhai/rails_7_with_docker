class ApplicationController < ActionController::API
  include ExceptionRescue
  include Response
  include DeviseTokenAuth::Concerns::SetUserByToken

  respond_to :json

  private
  def ensure_params_exist
    return unless params[:user].blank?
     render json: {message: "Missing params"}, status: 422
  end
end
