require 'test_helper'

class CommentLikeTest < ActiveSupport::TestCase
  def setup
    @comment_like = comment_likes(:one)
  end

  test "should be valid" do
    assert @comment_like.valid?
  end

  test "should belong to user" do
    assert_respond_to @comment_like, :user
    assert_instance_of User, @comment_like.user
  end

  test "should belong to comment" do
    assert_respond_to @comment_like, :comment
    assert_instance_of Comment, @comment_like.comment
  end
end
