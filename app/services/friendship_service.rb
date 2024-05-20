class FriendshipService
    def self.accept(req_id, current_user)
        request = FriendRequest.find_by!(id:req_id)
        return false if request.receiver_id != current_user.id.to_i

        # Accept request
        Friendship.create!(user_id: current_user.id.to_i, friend_id: request.sender_id) 
    end
end