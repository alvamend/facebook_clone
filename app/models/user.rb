class User < ApplicationRecord
    VALID_REGEX_EMAIL = /\A([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\z/

    before_save do
        self.first_name = first_name.downcase
        self.second_name = second_name.downcase if second_name.present?
        self.last_name = last_name.downcase
        self.email = email.downcase
    end

    validates :email, presence: true, uniqueness: true, format: {with: VALID_REGEX_EMAIL}
    validates :first_name, presence: true, length: {minimum:2, maximum:20}
    validates :last_name, presence: true, length: {minimum:2, maximum:20}

    has_secure_password
    has_one_attached :avatar
    has_many :likes
    has_many :posts
end