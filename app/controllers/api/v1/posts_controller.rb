module Api
    module V1
        class PostsController < ApplicationController
            rescue_from ActiveRecord::RecordNotFound, with: :not_found_records
            before_action :current_user

            def create
                post = @current_user.posts.create!(post_params)
                render json: {message:"post created"}, status: :created
            end

            def show
                post = Post.find_by!(id:params[:id])
                render json: {
                    post: post, 
                    user: "#{post.user.first_name} #{post.user.last_name}",
                    likes: post.likes.length
                }, status: 200
            end

            def update
                post = PostService.update_post(params, @current_user)
                if !post 
                    render json: {message: "you cannot modify this post or there was an error"}, status: :unprocessable_entity
                else
                    render json: {message: "post modified correctly"}, status: 200
                end
            end

            def destroy
                deleted_post = PostService.delete_post(params[:id], @current_user)
                if deleted_post
                    render json: {message: "post deleted"}, status: 200
                else
                    render json: {message: "post can only be deleted by the creator"}, status: :forbidden
                end
            end

            private
            def post_params
                params.permit(:description, :privacy, :images)
            end

            def not_found_records(e)
                render json: {message: "could not find post"}, status: :not_found
            end
        end
    end
end