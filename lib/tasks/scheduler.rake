desc "This task is called by the Heroku scheduler add-on"

task :send_billing_info => :environment do
  if DateTime.now.mday == 1
    User.where(locked: false).find_in_batches(batch_size: 1000) do |group|
      MailgunGateway.new.send_batch_message(group)
    end
  end
end
