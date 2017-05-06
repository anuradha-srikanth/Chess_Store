class Ability
  include CanCan::Ability

  def initialize(user)
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new


    if user.role? :admin
        can :manage, :all

    elsif user.role? :manager
        #can read everything
        can :read, :all

        #can read, edit or update employee data
        can :index, User do |this_user|
            employees = User.employees
            employees.include? this_user
        end
        can :create, User  do |this_user|
            employees = User.employees
            employees.include? this_user
        end

        can :update, User do |this_user|
            employees = User.employees
            employees.include? this_user
        end

        #can create, edit, read items 
        #upload pictures power?
        can :create, Item
        can :update, Item
        can :destroy, Item

        #can read full price history, create new prices
        can :index, ItemPrice
        can :create, ItemPrice

        #adjust inventory levels by adding purchases to system
        can :create, Purchase


    elsif user.role? :shipper
        # they can update their own profile
        can :update, User do |u|  
            u.id == user.id
        end

        #can read information about items but not price history
        can :index, Item

        can :read, Item

        can :index, Order do |this_order|
            unshipped_orders = Order.not_shipped; 
            unshipped_orders.include? this_order.id
        end


    elsif user.role? :customer
        can :update, User do |u|  
            u.id == user.id
        end
        # they can create new orders for themselves
        can :create, Order

        can :destroy, Order do |this_order|
            unshipped_orders = Order.not_shipped; 
            unshipped_orders.include? this_order.id
        end

        #can read info about items but not inventory level or 
        #price history
        can :read, Item

        #read own previous orders
        can :read, Order do |this_order|
            this_order.user_id == user.id
        end 

        #can add school
        can :create, School

    else
        can :read, Item

        can :create, User

        can :create, School


        #FIX THIS ONE
        cannot :view_employees, User
        cannot :view_customers, User


    end
end
end
