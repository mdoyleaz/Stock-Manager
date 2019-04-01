class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager
      can :manage, :all
    else
       can :read, Portfolio do |portfolio|
         portfolio.user == user
       end
        can :read, User do |user|
          user == user
        end
       cannot :manage, Investment
    end
  end
end
