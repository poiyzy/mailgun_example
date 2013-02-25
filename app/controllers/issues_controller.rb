class IssuesController < ApplicationController
  before_filter :require_admin

  def index
    @issues = Issue.order("created_at DESC")
  end
end
