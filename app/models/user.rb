class User < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns the most published category by the user
  def favourite_category
    counting = Hash.new
    # Counts all the categories
    self.microposts.each do |micropost|
      counting[micropost.category_id] ||= 1
      counting[micropost.category_id] += 1
    end

    favourite_category_key = 0
    counting.each do |key, value|
      highest ||= value
      favourite_category_key =  favourite_category_key == 0 ? key : favourite_category_key
      favourite_category_key = value > highest ? key : favourite_category_key
    end
    return nil if favourite_category_key == 0
    favourite_category_key
  end
end
