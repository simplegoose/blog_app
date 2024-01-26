class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    if user.role == 'admin'
      can :manage, Post
      can :manage, Comment
    else
      can :read, :create, Post
      can :read, :create, Comment
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
    end
  end
end
