class ArchivedAccountGuard < Clearance::SignInGuard
  def call
    if archived?
      failure("Your Account has been archived")
    else
      next_guard
    end
  end

  def archived?
    signed_in? && !current_user.archived_at.nil?
  end
end
