require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = notifications(:one)
  end

  test "should be valid" do
    assert @notification.valid?
  end

  test "should include Noticed::Model" do
    assert_includes Notification.included_modules, Noticed::Model
  end
end
