module Response
  def json_response_success object, serializer=nil, optional= ({})
    if serializer.present?
      render json: {
        success: true,
        data: object.kind_of?(Array) ? 
          ActiveModel::Serializer::CollectionSerializer.new(object, serializer: serializer)
          :
          serializer.new(object)
      }, status: :ok
    else
      render json: {
        success: true,
        data: object
      }, status: :ok
    end
  end

  def json_response_fail errors: [], status: 500
    render json: {
      success: false,
      errors: errors
    }, status: status
  end
end
