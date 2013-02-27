desc "This task is called by the Heroku scheduler add-on"
task :send_billing_info => :environment do
  MailgunGateway.new.send_batch_message if DateTime.now.mday == 1
end
