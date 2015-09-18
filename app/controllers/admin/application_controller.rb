class Admin::ApplicationController < ApplicationController
  before_action :authorise_admin!

  def index
  end

  private

  def authorise_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to do that"
    end
  end
end
