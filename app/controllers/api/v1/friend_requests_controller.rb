module Api
    module V1
        class FriendRequestsController < ApplicationController
            before_action :current_user

            def index
                requests = FriendRequest.is_receiver?(@current_user.id)
                render json: {requests: requests}, status: 200
            end

            def create
                if @current_user.id == params[:user_id].to_i
                    render json: {message: "cannot add yourself"}, status: :unprocessable_entity
                else
                    FriendRequest.create!(sender_id:@current_user.id, receiver_id: params[:user_id])
                    render json: {message: "friend request was sent"}, status: 200
                end
            end

            def accept_request
                request = FriendshipService.accept(params[:req_id], @current_user)
                puts request
            rescue ActiveRecord::RecordNotFound => e
                render json: {error: "friend request not found"}, status: :not_found
            end
        end
    end
end