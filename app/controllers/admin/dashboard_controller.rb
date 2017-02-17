class Admin::DashboardController < ApplicationController

  before_filter :authenticate


  def show
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end

end
