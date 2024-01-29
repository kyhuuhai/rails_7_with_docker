class ApplicationController < ActionController::API
  include ExceptionRescue
  include Response
  include Session
end
