require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(
      title: "Test Post Title",
      body: "This is a test post",
      user: users(:one)
    )
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = "   "
    assert_not @post.valid?
  end

  test "title should not be too short" do
    @post.title = "a" * 4
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 51
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = "   "
    assert_not @post.valid?
  end

  test "body should not be too short" do
    @post.body = "a" * 4
    assert_not @post.valid?
  end

  test "body should not be too long" do
    @post.body = "a" * 10001
    assert_not @post.valid?
  end

  test "should belong to user" do
    assert_respond_to @post, :user
    assert_instance_of User, @post.user
  end

  test "should optionally belong to topic" do
    assert_respond_to @post, :topic
    @post.topic = nil
    assert @post.valid?
  end

  test "should have many comments" do
    assert_respond_to @post, :comments
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @post.comments
  end

  test "should have many likes" do
    assert_respond_to @post, :likes
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @post.likes
  end

  test "should have many liked_by_users" do
    assert_respond_to @post, :liked_by_users
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @post.liked_by_users
  end

  test "should have many notifications" do
    assert_respond_to @post, :notifications
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @post.notifications
  end

  test "should have pinned scope" do
    assert_respond_to Post, :pinned
  end

  test "should have announcement scope" do
    assert_respond_to Post, :announcement
  end
end
