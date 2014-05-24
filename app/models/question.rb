class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_one :question_detail
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  belongs_to :user

  before_save :capitalize_title

  validates :title, presence: {message: "must be there"}, uniqueness: true
  validates :description, presence: {message: "must be present"}

  default_scope { order("created_at DESC") }

  scope :recent, ->(x) { order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("create_at DESC").limit(10) }

  private

  def capitalize_title
    self.title.capitalize!
  end

end
