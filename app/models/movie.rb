class Movie < ApplicationRecord
    has_one_attached :movie
    has_many :comments, dependent: :destroy

    belongs_to :user
    has_many :likes, dependent: :destroy

    validates :title, presence: true, length: { maximum: 30}
    validates :content, length: { maximum: 400}
    validates :movie, attached: true, content_type: ['video/mp4', 'video/MOV', 'video/wmv']
end


