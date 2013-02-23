class MailgunGateway
  def send_batch_message(options={})
    RestClient.post(messaging_api_end_point,
    from: default_sender,
    to: delivery_filter(options[:to]),
    subject: options[:subject],
    html: billing_info_text(options[:body]),
    )
  end

  private

  def default_sender
    "Mailgun Demo <billing-info@mailgun-demo.heroku.com>"
  end

  def api_key
    @api_key ||= "key-62guu2fxc9qujx8rbl5ebylsx3pet451"
  end

  def messaging_api_end_point
    @messaging_api_end_piont ||= "https://api:#{api_key}@api.mailgun.net/v2/zirannanren.com.mailgun.org/messages"
  end

  def delivery_filter(email)
    Rails.env.production? ? email : "zhuoyuyang@gmail.com"
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
