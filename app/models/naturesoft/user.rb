module Naturesoft
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
    belongs_to :user_group
    scope :ordered, -> { order('created_at desc') }
    
    mount_uploader :image, Naturesoft::UserUploader
    
    # additional validate
    validates :first_name, :last_name, presence: true
    
    # Display name
    def display_name
      first_name.to_s + " " + last_name.to_s
    end
    
    # Listing filter
    def self.sort_by
      [
        ["Name","full_name"],
        ["Created At","naturesoft_users.created_at"]
      ]
    end
    
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
    
    #Filter, Sort
    def self.search(params)
      records = self.select("*, CONCAT(naturesoft_users.first_name,' ',naturesoft_users.last_name) as full_name")
      
      #Search keyword filter
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_users.first_name,' ',naturesoft_users.last_name,' ',naturesoft_users.email)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_users.first_name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
  end
end
