class WelcomeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.welcome.subject
  #
  def welcome(user)
    @greeting = "Hi #{user.name},"
    @user = user

    mail( to: @user.email, subject: 'Welcome to Treasury.Love - Begin your Love-Journaling Journey')
  end
end
