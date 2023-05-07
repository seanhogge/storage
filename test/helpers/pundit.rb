module MiniTest
  module Assertions
    def assert_permitted(user, record, actions)
      actions = Array actions

      actions.each do |action|
        if record.respond_to? :name
          msg = "#{user.name} should be permitted to #{action} #{record.name} (but isn't)"
        elsif record.respond_to? :display_name
          msg = "#{user.name} should be permitted to #{action} #{record.display_name} (but isn't)"
        else
          msg = "#{user.name} should be permitted to #{action} #{record} (but isn't)"
        end
        assert Pundit.policy!(user, record).public_send(action), msg
      end
    end

    def refute_permitted(user, record, actions)
      actions = Array actions

      actions.each do |action|
        if record.respond_to? :name
          msg = "#{user.name} should not be permitted to #{action} #{record.name} (but is)"
        elsif record.respond_to? :display_name
          msg = "#{user.name} should not be permitted to #{action} #{record.display_name} (but is)"
        else
          msg = "#{user.name} should not be permitted to #{action} #{record} (but is)"
        end
        refute Pundit.policy!(user, record).public_send(action), msg
      end
    end
  end
end
