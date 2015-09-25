class User < ActiveRecord::Base
  include Clearance::User

  has_many :roles
  scope :excluding_archived, ->{ where(archived_at: nil) }

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def archive
    self.update(archived_at: Time.now)
  end

  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end
end
