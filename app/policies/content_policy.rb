class ContentPolicy < ApplicationPolicy
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
      :bin_id,
      :name,
      :condition,
    ]
  end

  def permitted_attributes
    if user == record.bin.storage_unit.user || user.admin?
      [
        :bin_id,
        :name,
        :condition,
      ]
    else
      [
        :bin_id,
        :name,
        :condition,
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
