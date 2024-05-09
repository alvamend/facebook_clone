class UserService
    def self.get_profile(user_id)
        user = User.find_by!(id:user_id)
    end
end