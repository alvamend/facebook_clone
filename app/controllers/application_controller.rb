class ApplicationController < ActionController::API
    def current_user
        @current_user = AuthService.get_current_user(request.headers["Authorization"])
    rescue JWT::ExpiredSignature => e
        render json: {error: e}, status: :unauthorized
    rescue JWT::DecodeError => e
        render json: {error: e}, status: :unauthorized
    end
end
