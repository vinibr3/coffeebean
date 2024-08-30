class User < ApplicationRecord
  ALL_USERS_CACHE_KEY = 'users'.freeze

  has_secure_password

  before_validation :cleasing

  validates :name, length: { minimum: 5, maximum: 128 }
  validates :email, presence: true,
                    format: URI::MailTo::EMAIL_REGEXP,
                    length: { maximum: 255 }
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 10, maximum: 72 }

  validate :password_characters_count
  validate :uniqueness_of_email

  def save_in_cache
    return false if invalid?

    users = User.all_from_cache
    users[email] = self
    Rails.cache.write(ALL_USERS_CACHE_KEY, users)

    User.all_from_cache[email]
  end

  def self.all_from_cache
    Rails.cache.fetch(ALL_USERS_CACHE_KEY, expires_in: 100.hours) do
      {}
    end
  end

  def to_param
    email
  end

  private

  def cleasing
    self.name = name.to_s.strip
    self.email = email.to_s.downcase.strip
    self.password = password.to_s.strip
  end

  def password_characters_count
    errors.add(:password, :digits, count: 2) if password.scan(/\d/).length < 2
    errors.add(:password, :upper, count: 2) if password.scan(/[[:upper:]]/).length < 2
    errors.add(:password, :lower, count: 2) if password.scan(/[[:lower:]]/).length < 2

    special_characters = "!#$%&'()*+,-./:;<=>?@[\]^_`{|}~".chars
    errors.add(:password, :special_character, count: 2) if password.chars.count{|p| p.in?(special_characters)} < 2
  end

  def uniqueness_of_email
    errors.add(:email, :uniqueness) if User.all_from_cache[:email].present?
  end
end
