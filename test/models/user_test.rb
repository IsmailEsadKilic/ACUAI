require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should not be too short" do
    @user.name = "a"
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should have many posts" do
    assert_respond_to @user, :posts
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.posts
  end

  test "should have many comments" do
    assert_respond_to @user, :comments
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.comments
  end

  test "should have many likes" do
    assert_respond_to @user, :likes
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.likes
  end

  test "should have many liked_posts" do
    assert_respond_to @user, :liked_posts
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.liked_posts
  end

  test "should have many notifications" do
    assert_respond_to @user, :notifications
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.notifications
  end

  test "should have many subscriptions" do
    assert_respond_to @user, :subscriptions
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.subscriptions
  end

  test "should have many subscribed_users" do
    assert_respond_to @user, :subscribed_users
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @user.subscribed_users
  end

  test "should validate profile picture mime type" do
    assert @user.private_methods.include?(:correct_profile_picture_mime_type)
  end
end
