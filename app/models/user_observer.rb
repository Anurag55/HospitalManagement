class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_login_credential_email(user)
  end
end
