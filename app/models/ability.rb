# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # case user.role
    # when "admin"
    #   can :access, :rails_admin
    #   can :dashboard
    #   can :manage, :all
    #   can :update, :post, user_id: user.id
    # when "member"
    # end
  end
end
