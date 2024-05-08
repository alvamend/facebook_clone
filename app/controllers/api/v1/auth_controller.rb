module Api
    module V1
        class AuthController < ApplicationController
            def create
                user_auth = AuthService.handle_login(params)
                if !user_auth[:status]
                    render json: {message: "invalid email or password"}, status: :unprocessable_entity
                else
                    render json: {token: user_auth[:token]}, status: 200
                end
            end

            def destroy
                puts "destroyed"
            end
        end
    end
end