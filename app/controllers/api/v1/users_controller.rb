module Api
    module V1
        class UsersController < ApplicationController
            def create
                user = User.create!(user_params)
                render json: {message: "user created"}, status: :created
            rescue ActiveRecord::RecordInvalid => e
                render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
            end

            private
            def user_params
                params.require(:user).permit(:first_name, :second_name, :last_name, :date_of_birth, :email, :password, :phone_number, :gender)
            end
        end
    end
end