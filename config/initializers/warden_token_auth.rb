require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class WardenTokenAuth < Authenticatable
      def authenticate!
        u = User.find_for_database_authentication(warden_auth_token: params[:token])
        if u 
          success! u
        else
          fail! 'error! wrong password'
        end
      end
    
      def valid?
        true
      end    
    end
  end
end

# Warden::Strategies.add(:warden_token_auth, Devise::Strategies::WardenTokenAuth)

