class Notifier < ActionMailer::Base
  def the_email
    @body = "Every email is spam."

    from       "do-not-reply@example.com"
    recipients "myself@me.com"
    subject    "This is spam"
  end
end
