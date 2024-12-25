# To deliver this notification:
#
# PostNotification.with(post: @post).deliver_later(current_user)
# PostNotification.with(post: @post).deliver(current_user)

class PostNotification < Noticed::Base
  # Add your delivery methods
  #
  # deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.

  def message
    @post = Post.find(params[:post][:id])
    @user = User.find(@post.user_id)
    "#{@user.name} created a new post titled #{@post.title.truncate_words(5)}"
  end

  # def url
  #   post_path(params[:post])
  # end
end
