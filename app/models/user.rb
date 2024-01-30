class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  before_create :generate_uid

  def generate_uid
    self.uid = SecureRandom.uuid
  end
end
