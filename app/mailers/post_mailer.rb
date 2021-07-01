class PostMailer < ApplicationMailer
  def post_mail(post)
        @post = post
        mail to: "myphotoclone@gmail.com", subject: "Image posting"
  end
  end
