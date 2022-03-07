class Question < ApplicationRecord
    has_one_attached :movie
    has_many :answers, dependent: :destroy

    belongs_to :user

    validates :title, presence: true, length: { maximum: 30}
    validates :content, presence: true, length: { maximum: 400}
    validates :movie, content_type: 'video/mp4'
end
