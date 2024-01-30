module Api::V1
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        if resource.persisted?
          json_response_success resource, UserSerializer and return
        else
          json_response_fail errors: resource.errors.full_messages, status: 422 and return
        end
      end
    end

    private
    def sign_up_params
      params.require(:user).permit :email, :password, :password_confirmation, :username, :fullname, :image
    end
  end
end
