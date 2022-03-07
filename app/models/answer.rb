class Answer < ApplicationRecord
  has_many :nices, dependent: :destroy
  belongs_to :question
  belongs_to :user
  validates :content, presence: true, length: { maximum: 400}
end
