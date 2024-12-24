class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  #set annoucements for all controllers
  before_action :set_announcements
  before_action :set_topics

  #notifications
  before_action :set_notifications, if: :current_user

  private

  def set_announcements

    @announcements = Post.announcement.order(created_at: :desc)
  end

  def set_topics
    @topics = Topic.all
  end

  def set_notifications
    notifications = Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end

end
