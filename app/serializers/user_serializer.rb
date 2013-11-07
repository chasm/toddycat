class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :url
  
  def url
    user_url(object)
  end
end
