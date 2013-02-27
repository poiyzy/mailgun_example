class Api::BouncedMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    if verify(ENV["mailgun_api_key"], params[:token], params[:timestamp], params[:signature])
      user = User.find_by_email(params[:recipient])
      if user && params[:event] == "bounced"
        user.lock!
      end
      head(200)
    end
  end

  private
  def verify(api_key, token, timestamp, signature)
    signature == OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest::Digest.new('sha256'),
      api_key,
      '%s%s' % [timestamp, token])
  end
end
