class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit

  # after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def sign_in(user)
    flash[:notice] = "You have signed in successfully"
    super(user)
  end

  private

  def not_authorized
    redirect_to root_path, alert: "You are not allowed to do that"
  end
end
