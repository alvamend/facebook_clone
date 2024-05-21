class Post < ApplicationRecord
    has_many_attached :images
    belongs_to :user
    has_many :likes
    has_many :comments
end