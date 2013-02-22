class Api::BouncedMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    user = User.find_by_email(params[:recipient])
    if user && params[:event] == "bounced"
      user.locked = true
      user.save
    end
    head(200)
  end
end
