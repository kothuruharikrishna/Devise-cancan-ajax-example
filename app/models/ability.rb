class Ability
  include CanCan::Ability

  def initialize(user)

   user ||= User.new
   if !user.id.nil?
      can :read, :all
      can :create, Comment
      can [:update, :destroy, :edit], Comment do |comment|
          comment && comment.user == user
       end
      can [:create,:autocomplete,:dropdown_sort], Post
      can [:update, :destroy, :edit], Post do |post|
          post && post.user == user
      end
    else
      can :read, Post
      can :autocomplete, Post
      can :dropdown_sort, Post 
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
