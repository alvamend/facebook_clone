class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'

    def self.are_friends?(user1, user2)
        friendship1 = Friendship.find_by(user_id: user1.id, friend_id: user2.id)
        friendship2 = Friendship.find_by(user_id: user2.id, friend_id: user1.id)

        !friendship1.nil? || !friendship2.nil?
    end
end