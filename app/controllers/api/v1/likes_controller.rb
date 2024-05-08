module Api
    module V1
        class LikesController < ApplicationController
            before_action :current_user

            def toggle_like
                action_performed = LikeService.toggle(params[:id], @current_user)
                render json: {message: action_performed[:result]}, status: 200
            rescue ActiveRecord::RecordNotFound => e
                render json: {error: "could not find post"}, status: :not_found
            end
        end
    end
end