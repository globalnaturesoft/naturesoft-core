module Naturesoft
  class ApplicationMailer < ActionMailer::Base
    default from: "#{Naturesoft::Option.options("core")["core"]["smtp"]["user_name"]}"
    layout 'mailer'
    
    private
    def send_email(email, subject)      
      @smtp = Naturesoft::Option.options("core")["core"]["smtp"]
      delivery_options = {address: @smtp["address"],
                          port: @smtp["port"],
                          domain: @smtp["domain"],
                          user_name: @smtp["user_name"],
                          password: @smtp["password"],
                          authentication: @smtp["authentication"]}
      mail(to: email,
           subject: subject,
           delivery_method_options: delivery_options)
    end
  end
end

