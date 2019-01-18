class UserMailer < ActionMailer::Base

  def login_credential_email(user)
  recipients    user.email
  from          "My Awesome Site Notifications <anuragmpayam@gmail.com>"
  subject       "Welcome to abc hospital"
  sent_on       Time.now
  body          :user => user, :url => "http://localhost:3000/sessions/"
  end

  def reset_email(user)
    recipients    user.email
    from          "My Awesome Site Notifications <anuragmpayam@gmail.com>"
    subject       "Welcome to abc hospital"
    sent_on       Time.now
    body          :user => user, :url => "http://localhost:3000/sessions/reset_password_form?token="+user.reset_token
  end

  def appointment_email(user,appointment)
    recipients    user.email
    from          "My Awesome Site Notifications <anuragmpayam@gmail.com>"
    subject       "Welcome to abc hospital"
    sent_on       Time.now
    body          :user => user, :appointment => appointment
  end

end
