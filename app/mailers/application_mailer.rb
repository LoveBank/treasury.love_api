class ApplicationMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: 'noreply@mg.treasury.love'
  layout 'mailer'
end
