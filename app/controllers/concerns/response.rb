module Response
  def json_response_success object, serializer=nil, optional= ({})
    render json: {
      success: true,
      data:
        is_array_or_collection(object) ?
          ActiveModel::Serializer::CollectionSerializer.new(object, serializer: serializer)
        :
          serializer.new(object)
    }.merge(optional), status: :ok
  end

  def json_response_fail errors: [], status: :internal_server_error
    render json: {
      success: false,
      errors: errors
    }, status: status
  end

  private
  def is_array_or_collection object
    object.count rescue false
  end
end
