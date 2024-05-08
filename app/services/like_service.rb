class LikeService
    def self.toggle(post_id, current_user)
        # Verify if post exists
        found_post = Post.find_by!(id: post_id)
        
        # Verify if like already exists
        already_liked = Like.find_by(user_id: current_user.id, post_id: post_id)

        # If like does not exist, create a new like record, else, destroy it
        if !already_liked
            Like.create!(user_id: current_user.id, post_id: post_id)
            return{
                result: "post liked succesfully"
            }
        else
            already_liked.delete
            return{
                result: "post disliked"
            }
        end
        
    end
end