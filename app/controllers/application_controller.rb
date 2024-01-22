class ApplicationController < ActionController::API
  include ExceptionRescue
  include Response
  include DeviseTokenAuth::Concerns::SetUserByToken
end
