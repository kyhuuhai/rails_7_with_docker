class Api::Errors::BaseErrorsSerializer < ActiveModel::Serializer
  attribute :success
  attribute :data

  def success
    false
  end
end
