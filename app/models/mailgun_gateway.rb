class MailgunGateway
  def send_batch_message(options={})
    RestClient.post(messaging_api_end_point,
    from: default_sender,
    to: delivery_filter(options[:to]),
    subject: options[:subject],
    html: billing_info_text(options[:body]),
    ) if Rails.env.staging? || Rails.env.production?
  end

  private

  def default_sender
    "Mailgun Demo <billing-info@mailgun-demo.heroku.com>"
  end

  def api_key
    @api_key ||= ENV["mailgun_api_key"]
  end

  def messaging_api_end_point
    @messaging_api_end_piont ||= "https://api:#{api_key}@api.mailgun.net/v2/zirannanren.com.mailgun.org/messages"
  end

  def delivery_filter(emails)
    Rails.env.production? ? emails : "zhuoyuyang@gmail.com"
  end

  def billing_info_text(user)
<<-EMAIL
<html><body>

Hi #{user.fullname},

<p>Your account created at #{user.created_at}</p>

</body></html>
EMAIL
  end
end
