require "test_helper"

class UsermailerMailerTest < ActionMailer::TestCase
  test "singup" do
    mail = UsermailerMailer.singup
    assert_equal "Singup", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
