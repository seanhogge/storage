class StorageUnitPolicy < ApplicationPolicy
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
    user == record.user || user.admin?
  end

  def update?
    user == record.user || user.admin?
  end

  def destroy?
    user == record.user || user.admin?
  end

  # https://github.com/varvet/pundit#strong-parameters
  def permitted_attributes_for_create
    [
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :website,
      :unit,
    ]
  end

  def permitted_attributes
    if user == record.user || user.admin?
      [
        :name,
        :address,
        :city,
        :state,
        :zip,
        :phone,
        :website,
        :unit,
      ]
    else
      [
        :name,
        :address,
        :city,
        :state,
        :zip,
        :phone,
        :website,
        :unit,
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
