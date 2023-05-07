class UserPolicy < ApplicationPolicy
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
      :first_name,
      :last_name,
      :announcements_read_at,
      :admin,
      :time_zone,
      :email,
      :encrypted_password,
      :reset_password_token,
      :reset_password_sent_at,
      :remember_created_at,
      :sign_in_count,
      :current_sign_in_at,
      :last_sign_in_at,
      :current_sign_in_ip,
      :last_sign_in_ip,
      :confirmation_token,
      :confirmed_at,
      :confirmation_sent_at,
      :unconfirmed_email,
      :failed_attempts,
      :unlock_token,
      :locked_at,
      :active,
      :roles,
      :supervisor_id,
    ]
  end

  def permitted_attributes
    if user == record.user || user.admin?
      [
        :first_name,
        :last_name,
        :announcements_read_at,
        :admin,
        :time_zone,
        :email,
        :encrypted_password,
        :reset_password_token,
        :reset_password_sent_at,
        :remember_created_at,
        :sign_in_count,
        :current_sign_in_at,
        :last_sign_in_at,
        :current_sign_in_ip,
        :last_sign_in_ip,
        :confirmation_token,
        :confirmed_at,
        :confirmation_sent_at,
        :unconfirmed_email,
        :failed_attempts,
        :unlock_token,
        :locked_at,
        :active,
        :roles,
        :supervisor_id,
      ]
    else
      [
        :first_name,
        :last_name,
        :announcements_read_at,
        :admin,
        :time_zone,
        :email,
        :encrypted_password,
        :reset_password_token,
        :reset_password_sent_at,
        :remember_created_at,
        :sign_in_count,
        :current_sign_in_at,
        :last_sign_in_at,
        :current_sign_in_ip,
        :last_sign_in_ip,
        :confirmation_token,
        :confirmed_at,
        :confirmation_sent_at,
        :unconfirmed_email,
        :failed_attempts,
        :unlock_token,
        :locked_at,
        :active,
        :roles,
        :supervisor_id,
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
