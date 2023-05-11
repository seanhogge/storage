class BinPolicy < ApplicationPolicy
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
    user
  end

  def update?
    user
  end

  def destroy?
    user.admin?
  end

  # https://github.com/varvet/pundit#strong-parameters
  def permitted_attributes_for_create
    [
      :id,
      :storage_unit_id,
    ]
  end

  def permitted_attributes
    if user == record.storage_unit.user || user.admin?
      [
        :id,
        :storage_unit_id,
      ]
    else
      [
        :id,
        :storage_unit_id,
      ]
    end
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.all
      end
    end
  end
end
