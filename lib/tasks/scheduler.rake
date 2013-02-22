desc "This task is called by the Heroku scheduler add-on"
task :send_billing_info => :environment do
  User.where(locked: false).each do |user|
    MailgunGateway.new.send_batch_message(
      to: user.email, subject: "Monthly Billing Info",
      body: user
    )
  end
end
