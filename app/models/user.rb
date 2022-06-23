class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

    USER_TYPE = {admin: 0,teacher: 1,student: 2}
    
    enum user_type: USER_TYPE       
end
