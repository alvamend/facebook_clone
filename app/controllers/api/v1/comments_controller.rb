module Api
    module V1
        class CommentsController < ApplicationController
            before_action :current_user
            def create
                params_with_ids = comment_params.merge(post_id: params[:post_id], user_id: @current_user.id)
                comment = Comment.create!(params_with_ids)
                render json: {message:"comment created"}, status: :created
            rescue ActiveRecord::RecordInvalid => e
                render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
            end

            private
            def comment_params
                params.require(:comment).permit(:content, :post_id, :user_id)
            end
        end
    end
end