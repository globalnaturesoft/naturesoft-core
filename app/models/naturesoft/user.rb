module Naturesoft
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
    scope :ordered, -> { order('created_at desc') }
    
    mount_uploader :image, Naturesoft::UserUploader
    
    # additional validate
    validates :first_name, :last_name, presence: true
    
    # Display name
    def display_name
      first_name.to_s + " " + last_name.to_s
    end
    
  end
end
