class Post < ApplicationRecord
end
class Post < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["user_id", "title", "content", "id"]
  end
end
