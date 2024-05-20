class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'

    scope :is_receiver?, -> (id){where(receiver_id: id)}
end