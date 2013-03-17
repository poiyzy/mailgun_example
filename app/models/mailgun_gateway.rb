class MailgunGateway
  include Rails.application.routes.url_helpers

  def send_batch_message(users)
    RestClient.post(messaging_api_end_point,
    from: "Mailgun Demo <billing@#{ENV["mailgun_domain_name"]}>",
    to: users.map(&:email).join(", "),
    subject: "Monthly Billing Info",
    html: billing_info_text,
    :"h:Reply-To" =>  "billing@#{ENV["mailgun_domain_name"]}",
    :"recipient-variables" => recipient_variables(billing_recipients)
    )
  end

  private

  def api_key
    @api_key ||= ENV["mailgun_api_key"]
  end

  def messaging_api_end_point
    @messaging_api_end_piont ||= "https://api:#{api_key}@api.mailgun.net/v2/#{ENV["mailgun_domain_name"]}/messages"
  end

  def billing_recipients
    @users ||= User.where(locked: false)
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
to see details.
</p>
<p>Reply to this email directly</p>

</body></html>
EMAIL
  end
end
