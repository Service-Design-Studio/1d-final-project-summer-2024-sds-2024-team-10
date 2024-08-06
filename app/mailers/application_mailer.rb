class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def sample_email
    mail(to: 'test@example.com', subject: 'Sample Email') do |format|
      format.text { render plain: "This is a sample email body." }
    end
  end
end
