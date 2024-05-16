class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("active.subject")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mail.reset_password.subject")
  end

  def password_reset_success user
    mail to: user.email, subject: t("mail.send_mail_success.subject")
  end
end
