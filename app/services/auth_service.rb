class AuthService
    def self.handle_login(params)
        # Find user and validate password
        user = User.find_by(email:params[:email])&.authenticate(params[:password])

        if !user
            return{
                status: false
            }
        else
            payload = {
                id: user.id,
                email: user.email,
                exp: 30.seconds.from_now.to_i
            }

            # Generate token 
            token = JWT.encode payload, ENV['SECRET_KEY'], ENV['ALGORITHM']

            return {
                status: true,
                token: token
            }
        end
    end

    def self.get_current_user(token)
        valid_token = JWT.decode token, ENV["SECRET_KEY"], true, {algorithm: ENV["ALGORITHM"]}
    end
end