class StaticPagesController < ApplicationController
  def index
  end

  def billing
    @date = current_user.created_at
  end
end
