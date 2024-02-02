module Api::V1
  class ApiController < ApplicationController
    include ExceptionRescue
    include Response
    include SessionApi

    protect_from_forgery with: :null_session

    respond_to :json
  end
end
