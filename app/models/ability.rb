class Ability
  include CanCan::Ability
  include Alchemy::Permissions::EditorUser

  def initialize(user)
    return if user.nil?
    @user ||= user
    if @user.has_role?(:demo)
      alchemy_editor_rules

      # Navigation
      can [:index], :alchemy_admin_sites
      can [:index], :alchemy_admin_users

      # Controller actions
      can [:info, :update_check], :alchemy_admin_dashboard

      # Resources
      can [:index, :edit], Alchemy::Language
      can [:index, :edit], Alchemy::Site
      can [:index], Alchemy.user_class
      can [:update], Alchemy.user_class, id: user.id
    end
  end
end
