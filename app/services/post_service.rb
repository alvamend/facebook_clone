class PostService
    def self.delete_post(id, current_user)
        # Only creator can delete the post
        post = Post.find_by!(id)
        if current_user.id != post.user_id
            return false
        else
            post.delete
            return true
        end
    end

    def self.update_post(params, current_user)
        post = Post.find_by!(id:params[:id])
        return false unless post && current_user.id == post.user_id

        if post.update(post_params(params))
            return true
        else
            return false
        end
    end

    private
    def self.post_params(params)
        params.require(:post).permit(:description, :privacy)
    end
end