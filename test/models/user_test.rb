require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "active scope returns active users" do
    assert User.active.map(&:active?).all?

    User.update_all active: false
    assert_equal User.active.count, 0
  end

  test "supervised_by returns correct users" do
    assert_includes User.supervised_by(users(:sean)), users(:henry)
    assert_includes User.supervised_by(users(:sean)), users(:andrew)
    assert_includes User.supervised_by(users(:henry)), users(:josh)
    assert_includes User.supervised_by(users(:andrew)), users(:edward)
  end

  test "users report correct roles" do
    assert users(:sean).active_role, :admin
    assert users(:sean).admin?
    refute users(:sean).manager?
    refute users(:sean).employee?

    assert users(:henry).active_role, :manager
    refute users(:henry).admin?
    assert users(:henry).manager?
    refute users(:henry).employee?

    assert users(:andrew).active_role, :manager
    refute users(:andrew).admin?
    assert users(:andrew).manager?
    refute users(:andrew).employee?

    assert users(:josh).active_role, :employee
    refute users(:josh).admin?
    refute users(:josh).manager?
    assert users(:josh).employee?

    assert users(:edward).active_role, :employee
    refute users(:edward).admin?
    refute users(:edward).manager?
    assert users(:edward).employee?
  end

  test "manager_plus? shows only managers and admins" do
    assert users(:sean).manager_plus?
    assert users(:henry).manager_plus?
    assert users(:andrew).manager_plus?
    refute users(:josh).manager_plus?
    refute users(:edward).manager_plus?
  end

  test "subordinates show correct users" do
    assert_includes users(:sean).subordinates, users(:henry)
    assert_includes users(:sean).subordinates, users(:andrew)
    assert_includes users(:sean).subordinates, users(:josh)
    assert_includes users(:sean).subordinates, users(:edward)

    refute_includes users(:henry).subordinates, users(:sean)
    refute_includes users(:henry).subordinates, users(:andrew)
    assert_includes users(:henry).subordinates, users(:josh)
    refute_includes users(:henry).subordinates, users(:edward)

    refute_includes users(:andrew).subordinates, users(:sean)
    refute_includes users(:andrew).subordinates, users(:henry)
    refute_includes users(:andrew).subordinates, users(:josh)
    assert_includes users(:andrew).subordinates, users(:edward)

    refute_includes users(:josh).subordinates, users(:sean)
    refute_includes users(:josh).subordinates, users(:henry)
    refute_includes users(:josh).subordinates, users(:andrew)
    refute_includes users(:josh).subordinates, users(:edward)

    refute_includes users(:edward).subordinates, users(:sean)
    refute_includes users(:edward).subordinates, users(:henry)
    refute_includes users(:edward).subordinates, users(:andrew)
    refute_includes users(:edward).subordinates, users(:josh)
  end
end
