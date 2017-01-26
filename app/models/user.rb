class User < ApplicationRecord
  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User
  include Swagger::Blocks
 
  swagger_schema :User do
    key :required, [:id, :email]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :email do
      key :type, :string
    end
  end

  enum role: [:user, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  
  has_many :alerts
end
