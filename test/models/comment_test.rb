require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:one)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "body should be present" do
    @comment.body = "   "
    assert_not @comment.valid?
  end

  test "body should not be too short" do
    @comment.body = "a" * 4
    assert_not @comment.valid?
  end

  test "body should not be too long" do
    @comment.body = "a" * 1001
    assert_not @comment.valid?
  end

  test "should belong to post" do
    assert_respond_to @comment, :post
    assert_instance_of Post, @comment.post
  end

  test "should belong to user" do
    assert_respond_to @comment, :user
    assert_instance_of User, @comment.user
  end

  test "should have many comment likes" do
    assert_respond_to @comment, :comment_likes
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @comment.comment_likes
  end

  test "should have many liked by users" do
    assert_respond_to @comment, :liked_by_users
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @comment.liked_by_users
  end

  test "should have noticed notifications" do
    assert_respond_to @comment, :notifications
  end


end
