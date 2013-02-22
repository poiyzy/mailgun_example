class MailgunGateway
  def send_batch_message(options={})
    RestClient.post(messaging_api_end_point,
        from: default_sender,
        to: delivery_filter(options[:to]),
        subject: options[:subject],
        html: options[:body],
        :"h:Reply-To" => options[:reply_to],
        :"recipient-variables" => options[:recipient_variables]
        ) if Rails.env.staging? || Rails.env.production?
  end

  private

  def default_sender
    "Mailgun Demo"
  end

  def api_key
    @api_key ||= "key-62guu2fxc9qujx8rbl5ebylsx3pet451"
  end

  def messaging_api_end_point
    @messaging_api_end_piont ||= "https://api:#{api_key}@api.mailgun.net/v2/zirannanren.com.mailgun.org/messages"
  end

  def delivery_filter(emails)
    Rails.env.production? ? emails : "zhuoyuyang@gmail.com"
  end
end
