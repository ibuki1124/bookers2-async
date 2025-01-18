class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # 自分がフォローする側の関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローされる側の関係
  has_many :relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :relationships, source: :followed
  has_many :followers, through: :relationships, source: :follower
  # フォローするとき
  # def follow(user)
  #   relationships.create(followed_id: user.id)
  # end
  # フォローを外すとき
  # def unfollow(user)
  #   relationships.find_by(followed_id: user.id).destroy
  # end
  # フォローしているか確認するとき
  def following?(user)
    following.Include?(user)
  end
  
  has_one_attached :profile_image
  
  # プロフィール画像
  def  get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  validates :name, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
end
