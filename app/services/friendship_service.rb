class FriendshipService
    def self.accept(req_id, current_user)
        # Find the Friend Request first
        request = FriendRequest.find_by!(id:req_id)

        # Return false if the logged user is not the receiver of the friend request
        return {result: false, message: "only the receiver can accept friend requests"} if request.receiver_id != current_user.id.to_i

        # Validate if the users are already friends
        already_friends = Friendship.are_friends?(request.sender, request.receiver)

        # If there is an existing friendship, we should return false
        return {result: false, message: "users are already friends"} if already_friends

        # Accept request if there is no existing friendship between both users
        Friendship.create!(user_id: current_user.id.to_i, friend_id: request.sender_id)
        return {result: true, message: "friendship accepted"}
    end
end