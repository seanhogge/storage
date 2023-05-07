class User < ApplicationRecord
  ROLES = %i[admin manager employee].freeze
  TableBreakpoint = "xl"
  TableBreakpointWidth = "1280"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :trackable, :lockable, :confirmable

  belongs_to :supervisor, class_name: "User", optional: true

  has_one_attached :avatar

  has_many :notifications, as: :recipient, dependent: :destroy

  has_person_name

  validates :name, presence: true
  validates :avatar, resizable_image: true

  scope :active, -> { where(active: true) }
  scope :supervised_by, ->(user) { where(supervisor_id: user.id) }

  store_accessor :roles, *ROLES

  # Cast roles to/from booleans
  ROLES.each do |role|
    scope role, -> { where("roles @> ?", {role => true}.to_json) }

    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  # You can use Postgres' jsonb operators to query the roles jsonb column
  # https://www.postgresql.org/docs/current/functions-json.html
  #
  # Query where roles contains:
  # scope :managers, -> { where("roles @> ?", {manager: true}.to_json) }

  def self.form_select
    active.map { |user| [user.user.name, user.id] }
  end

  def active_role
    ROLES.select { |role| send(:"#{role}?") }.compact.first
  end

  def manager_plus?
    manager? || admin?
  end

  def owner_must_be_admin
    unless admin?
      errors.add :admin, :cannot_be_removed
    end
  end

  def subordinates
    if admin?
      User.all.excluding(self)
    else
      User.where(supervisor_id: id)
    end
  end
  alias supervised subordinates

  def subordinates_and_self
    User.where(supervisor_id: id).or(User.where(id: id))
  end
  alias supervised_and_self subordinates_and_self

  def supervised_chain
    supervised_users = subordinates.to_a
    subordinates.each do |user|
      supervised_users << User.where(supervisor_id: user.id)
    end
    supervised_users.flatten
  end
  alias subordinate_chain supervised_chain

  def supervisor_chain
    supervisors = []
    current_user = self

    while current_user.supervisor && current_user != current_user.supervisor
      supervisors << current_user.supervisor
      current_user = current_user.supervisor
    end

    supervisors
  end

  def supervisor_name
    supervisor&.name || "N/A"
  end

  def role
    active_role.to_s.titleize
  end

  def tz
    ActiveSupport::TimeZone[time_zone].tzinfo.abbreviation
  end
end
