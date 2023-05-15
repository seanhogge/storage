class AttachmentPolicy < ApplicationPolicy
  # https://github.com/varvet/pundit
  # See ApplicationPolicy for defaults

  def destroy?
    user.admin?
  end

  def permitted_attributes
    if user == record.storage_unit.user || user.admin?
      [
        :id,
        :storage_unit_id,
        :images,
      ]
    else
      [
        :id,
        :storage_unit_id,
        :images,
      ]
    end
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
