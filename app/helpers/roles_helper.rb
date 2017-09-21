module RolesHelper
  def role_options()
    Role.all.pluck('info, id')
  end
end
