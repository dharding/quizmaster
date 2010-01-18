class AccountNotifier < ActionMailer::Base
  def activation_instructions(user)
    subject       "Quiz Master Activation Instructions"
    from          "Quiz Master Notifier <noreply@quizmaster.heroku.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token, :host => HOST)
  end

  def activation_confirmation(user)
    subject       "Quiz Master Activation Complete"
    from          "Quiz Master Notifier <noreply@quizmaster.heroku.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url(:host => HOST)
  end

  def reset_password_instructions(user)
    subject       "Quiz Master Reset Password Instructions"
    from          "Quiz Master Notifier <noreply@quizmaster.heroku.com>"
    recipients    user.email
    sent_on       Time.now
    body          :reset_password_url => reset_password_url(user.perishable_token, :host => HOST)
  end
end