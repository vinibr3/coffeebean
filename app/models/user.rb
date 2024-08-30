class User < ApplicationRecord
  has_secure_password

  validates :name, length: { minumum: 5, maximum: 128 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: URI::MailTo::EMAIL_REGEXP,
                    length: { maximum: 255 }
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 10, maximum: 72 }

  validate :password_characters_count

  before_save :changes_email_to_downcase

  private

  def changes_email_to_downcase
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
end
