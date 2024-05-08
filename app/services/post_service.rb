class PostService
    def self.delete_post(id, current_user)
        post = Post.find_by(id)
        if current_user.id != post.user_id
            return false
        else
            post.delete
            return true
        end
    end
end