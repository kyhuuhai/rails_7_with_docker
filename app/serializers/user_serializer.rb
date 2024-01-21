class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :fullname
end
