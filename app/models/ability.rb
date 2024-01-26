class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    if user.role == 'admin'
      can :manage, Post
      can :manage, Comment
    else
      can :read, Post
      can :read, Comment
    end
  end
end
