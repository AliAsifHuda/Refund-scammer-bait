class AdminUser < ApplicationRecord
    has_secure_password

    validates :username , presence: true,
                        uniqueness: { case_sensitive: false},
                        length: { minimum:4,maximum:15}
                          
    validates :password , presence: true,
              length: { minimum:4,maximum:15}
    
    before_save:down_username
    private
        def down_username()
            self.username = self.username.downcase
        end           
end
