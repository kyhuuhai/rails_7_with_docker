class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery unless: -> { request.format.json? }

  respond_to :json

  private
  def ensure_params_exist
    return unless params[:user].blank?
     render json: {message: "Missing params"}, status: 422
  end
end
