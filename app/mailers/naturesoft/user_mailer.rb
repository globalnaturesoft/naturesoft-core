module Naturesoft
  class UserMailer < ApplicationMailer
    default from: 'soft.support@hoangkhang.com.vn'
 
    def sending_email_contact(contact, contact_info)
      @contact = contact
      @contact_info = contact_info
      mail(to: @contact_info.email, subject: "[Thông báo] Bạn nhận được một liên hệ từ #{@contact.email}")
    end
  end
end
