class AccessCodePolicy < ApplicationPolicy
  # https://github.com/varvet/pundit
  # See ApplicationPolicy for defaults

  def index?
    user
  end

  def show?
    user
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    user == record.storage_unit.user || user.admin?
  end

  def update?
    user == record.storage_unit.user || user.admin?
  end

  def destroy?
    user == record.storage_unit.user || user.admin?
  end

  # https://github.com/varvet/pundit#strong-parameters
  def permitted_attributes_for_create
    [
      :storage_unit_id,
      :name,
      :code,
    ]
  end

  def permitted_attributes
    if user == record.user || user.admin?
      [
        :storage_unit_id,
        :name,
        :code,
      ]
    else
      [
        :storage_unit_id,
        :name,
        :code,
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
