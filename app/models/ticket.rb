class Ticket < ApplicationRecord
  include PgSearch

  attr_accessor :tag_names

  before_create :assign_default_state
  after_create :author_watches_me

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  belongs_to :project
  belongs_to :state
  belongs_to :author, class_name: "User"

  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers", class_name: "User", uniq: true

  pg_search_scope :search, :associated_against => {
    :tags => [:name],
    :state => [:name]
  }

  def tag_names
    @tag_names
  end

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end

  private

  def assign_default_state
    self.state ||= State.default
  end

  def author_watches_me
    if author.present? && !self.watchers.include?(author)
      self.watchers << author
    end
  end
end
