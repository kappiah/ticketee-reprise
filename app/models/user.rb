class User < ActiveRecord::Base
  include Clearance::User

  scope :excluding_archived, ->{ where(archived_at: nil) }

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def archive
    self.update(archived_at: Time.now)
  end
end
