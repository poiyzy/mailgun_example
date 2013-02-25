class MailgunGateway
  def send_batch_message
    RestClient.post(messaging_api_end_point,
    from: "Mailgun Demo <billing-info@mailgun-demo.heroku.com>",
    to: billing_recipients.map(&:email).join(", "),
    subject: "Monthly Billing Info",
    html: billing_info_text,
    recipient_variables: recipient_variables(billing_recipients),
    ) if Rails.env.staging? || Rails.env.production?
  end

  private

  def api_key
    @api_key ||= ENV["mailgun_api_key"]
  end

  def messaging_api_end_point
    @messaging_api_end_piont ||= "https://api:#{api_key}@api.mailgun.net/v2/#{ENV["mailgun_domain_name"]}/messages"
  end

  def billing_recipients
    User.where(locked: false)
  end

  def recipient_variables(recipients)
    vars = recipients.map do |recipient|
      "\"#{recipient.email}\": {\"name\":\"#{recipient.fullname}\"}"
    end
    "{#{vars.join(', ')}}"
  end

  def billing_info_text
<<-EMAIL
<html><body>

Hi %recipient.name%,

<p>
Your bill for the current month is now available, please click on
<br/>
#{billing_url}
<br/>
#to see details.
</p>

</body></html>
EMAIL
  end
end
