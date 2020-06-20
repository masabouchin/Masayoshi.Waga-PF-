class AdClient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :company_name, presence: true
  validates :company_name_kana, presence: true,format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :ceo_name, presence: true
  validates :ceo_name_kana, presence: true
  validates :address, presence: true
  validates :ceo_name_kana, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true
  validates :registry_image, presence: {
    message: -> (rec, data){
      I18n.t('activemodel.errors.message.not_upload')
    }
  }

  attachment :profile_image
  attachment :registry_image

  has_many :ads

  has_many :rooms

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "RelationshipOwner", foreign_key: "followed_id", dependent: :destroy # フォロワー取得

  has_many :following_owner, :through => :follower, :source => :followed #自分がフォローしているオーナー様
  has_many :follower_owner, :through => :followed, :source => :follower #自分をフォローしているオーナー様

  enum user_status: {not_check: 0, checked_indentification: 1}
  # not_check: 未確認, checked_indentification: 本人確認済み

  geocoded_by :address
  after_validation :geocode

  def follow(owner_id)
    follower.create(followed_id: owner_id)
  end
  def unfollow(owner_id)
    follower.find_by(followed_id: owner_id).destroy
  end
  def following(owner_id)
    follower.find_by(followed_id: owner_id)
  end
end
