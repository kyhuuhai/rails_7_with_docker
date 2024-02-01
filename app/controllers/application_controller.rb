class ApplicationController < ActionController::Base
  include ExceptionRescue
  include Response
  include Session
end
