class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :comments, dependent: :destroy
  validates_presence_of :body

  scope :order_by_creation, -> { order("created_at DESC") }
end
