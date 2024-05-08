module Api
    module V1
        class PostsController < ApplicationController
            before_action :current_user

            def create
                post = @current_user.posts.create!(post_params)
                render json: {message:"post created"}, status: :created
            end

            def show
                post = Post.find_by!(id:params[:id])
                render json: {post: post}, status: 200
            rescue ActiveRecord::RecordNotFound => e
                render json: {message: "could not find post"}, status: :not_found
            end

            def update
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
        end
    end
end