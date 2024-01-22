module Response
  def json_response object, serializer= nil, optional= ({})
    render json: object, each_serializer: serializer, optional: optional, status: 200
  end
end