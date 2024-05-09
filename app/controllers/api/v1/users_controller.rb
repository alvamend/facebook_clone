module Api
    module V1
        class UsersController < ApplicationController
            before_action :current_user, only: [:change_avatar, :show]

            def create
                user = User.create!(user_params)
                render json: {message: "user created"}, status: :created
            rescue ActiveRecord::RecordInvalid => e
                render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
            end

            def show
                user = UserService.get_profile(params[:id])
                avatar = user.avatar.attached? ? url_for(user.avatar) : nil
                render json: {
                    user:{
                        information: user,
                        avatar: avatar,
                        posts: user.posts.length
                    }
                }, except: [:password_digest, :created_at, :updated_at], status: 200
            rescue ActiveRecord::RecordNotFound => e
                render json: {error: "user not found"}, status: :not_found
            end

            def change_avatar
                if @current_user.avatar.attach(params[:avatar])
                    render json: {message: "avatar changed"}, status: 200
                end
            end

            private
            def user_params
                params.require(:user).permit(:first_name, :second_name, :last_name, :date_of_birth, :email, :password, :phone_number, :gender)
            end
        end
    end
end