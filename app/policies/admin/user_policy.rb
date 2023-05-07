# frozen_string_literal: true

# https://github.com/varvet/pundit
class Admin::UserPolicy < ApplicationPolicy
  attr_reader :user

  def index?
    user.admin? || user.manager?
  end

  def edit?
    user.admin? ||
      (user.manager? && !record.admin?) ||
      user == record
  end

  def update?
    user.admin? ||
      (user.manager? && !record.admin?) ||
      user == record
  end

  def import?
    user.admin?
  end

  def impersonate?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.supervised_by(user)
      end
    end
  end
end
