class Api::IncommingMessagesController < ApplicationControler
  skip_before_filter :verify_authenticity_token

  def create
    user = User.where(email: params['sender']).first
    text = params["stripped-text"]
    if user && text.present?
      user.issues.create content: text
    end
    head(200)
  end
end
