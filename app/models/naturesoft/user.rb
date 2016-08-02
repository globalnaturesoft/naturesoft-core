module Naturesoft
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    scope :ordered, -> { order('created_at desc') }
    
    # Display name
    def display_name
      email.split("@").first
    end
    
  end
end
