require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic = topics(:one)
  end

  test "should be valid" do
    assert @topic.valid?
  end

  test "name should be present" do
    @topic.name = "   "
    assert_not @topic.valid?
  end

  test "name should be unique" do
    duplicate_topic = @topic.dup
    duplicate_topic.name = @topic.name
    assert_not duplicate_topic.valid?
  end

  test "should have many posts" do
    assert_respond_to @topic, :posts
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @topic.posts
  end
end
