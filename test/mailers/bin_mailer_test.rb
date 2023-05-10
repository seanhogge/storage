require "test_helper"

class BinMailerTest < ActionMailer::TestCase
  test "new_bin" do
    mail = BinMailer.new_bin
    assert_equal "New bin", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
