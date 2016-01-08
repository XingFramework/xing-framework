class Role::Admin < Role
  Role.register 'Admin', self

  def set_abilities(ability)
    ability.can :manage, User
  end

end
