module Api
    module V1
        class FriendRequestsController < ApplicationController
            before_action :current_user

            def create
                if @current_user.id == params[:user_id].to_i
                    render json: {message: "cannot add yourself"}, status: :unprocessable_entity
                else
                    FriendRequest.create!(sender_id:@current_user.id, receiver_id: params[:user_id])
                    render json: {message: "friend request was sent"}, status: 200
                end
            end
        end
    end
end