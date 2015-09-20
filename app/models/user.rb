class User < ActiveRecord::Base
  include Clearance::User

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
