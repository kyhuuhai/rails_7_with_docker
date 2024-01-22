module ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalidation_response
    rescue_from ActiveRecord::RecordNotFound,
      ArgumentError, ActiveRecord::RecordNotDestroyed, with: :render_params_error_response
    rescue_from ExceptionRescue::ParameterMissing, with: :render_params_error_response

    def render_invalidation_response exception
      render json: exception, serializer: Api::Errors::ValidationErrorsSerializer,
        status: :bad_request
    end

    def render_params_error_response exception
      render json: exception, serializer: Api::Errors::ParamsErrorsSerializer,
        status: :bad_request
    end
  end

  class ParameterMissing < StandardError; end
end
