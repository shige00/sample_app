class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

    has_one_attached :avatar, dependent: :destroy
    has_many :movies, dependent: :destroy
    has_many :questions, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :nices, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :answers, dependent: :destroy

    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow

    has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :user

    validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg']
    validates :name, presence: true, length: { maximum: 10}
    # 動画にすでにいいねしているか確認
    def liked_by?(movie_id)
      likes.where(movie_id: movie_id).exists?
    end
    # コメントにすでにいいねしているか確認
    def niced_by?(answer_id)
      nices.where(answer_id: answer_id).exists?
    end
    # フォロー機能　自分自身でないか確認　すでにフォローしているか確認
    def follow(other_user)
      return if self == other_user
      relationships.find_or_create_by!(follow: other_user)
    end
    # フォローがあればアンフォローする
    def unfollow(relathinoship_id)
      relationships.find(relathinoship_id).destroy!
    end
    #フォローしているuserに含まれているか確認
    def following?(user)
      followings.include?(user)
    end

end
