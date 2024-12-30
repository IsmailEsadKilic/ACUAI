require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = likes(:one)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "should belong to user" do
    assert_respond_to @like, :user
    assert_instance_of User, @like.user
  end

  test "should belong to post" do
    assert_respond_to @like, :post
    assert_instance_of Post, @like.post
  end

  test "should validate uniqueness of user_id scoped to post_id" do
    duplicate_like = @like.dup
    assert_not duplicate_like.valid?
  end
end
