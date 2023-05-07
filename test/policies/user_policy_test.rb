require 'test_helper'

class Admin::UserPolicyTest < ActiveSupport::TestCase
  def setup
    @sean = users :sean # admin
    @henry = users :henry # manager
    @andrew = users :andrew # manager
    @josh = users :josh # employee
    @edward = users :edward # employee
  end

  test "an admin can" do
    assert_permitted @sean, [:admin, @sean], [:edit?, :update?]
    assert_permitted @sean, [:admin, @henry], [:edit?, :update?]
    assert_permitted @sean, [:admin, @andrew], [:edit?, :update?]
    assert_permitted @sean, [:admin, @josh], [:edit?, :update?]
    assert_permitted @sean, [:admin, @edward], [:edit?, :update?]
  end

  test "a manager can" do
    assert_permitted @henry, [:admin, @andrew], [:edit?, :update?]
    assert_permitted @henry, [:admin, @josh], [:edit?, :update?]
    assert_permitted @henry, [:admin, @edward], [:edit?, :update?]

    assert_permitted @andrew, [:admin, @henry], [:edit?, :update?]
    assert_permitted @andrew, [:admin, @josh], [:edit?, :update?]
    assert_permitted @andrew, [:admin, @edward], [:edit?, :update?]
  end

  test "a user can" do
    assert_permitted @josh, [:admin, @josh], [:edit?, :update?]
    assert_permitted @edward, [:admin, @edward], [:edit?, :update?]
  end

  test "a manager can not" do
    refute_permitted @henry, [:admin, @sean], [:edit?, :update?]
    refute_permitted @andrew, [:admin, @sean], [:edit?, :update?]
  end

  test "an employee can not" do
    refute_permitted @josh, [:admin, @sean], [:edit?, :update?]
    refute_permitted @josh, [:admin, @henry], [:edit?, :update?]
    refute_permitted @josh, [:admin, @andrew], [:edit?, :update?]
    refute_permitted @josh, [:admin, @edward], [:edit?, :update?]
  end
end
