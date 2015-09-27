class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :ticket

  validates :text, presence: true
  delegate :project, to: :ticket

  scope :persisted, ->{ where.not(id: nil) }
end
