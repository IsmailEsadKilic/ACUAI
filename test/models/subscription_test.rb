require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @subscription = subscriptions(:one)
  end

  test "should be valid" do
    assert @subscription.valid?
  end

end
