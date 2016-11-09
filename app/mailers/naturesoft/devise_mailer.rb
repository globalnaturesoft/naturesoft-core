module Naturesoft
  class DeviseMailer < Devise::Mailer
    def reset_password_instructions(record, token, opts={})
      @token = token
      @smtp = Naturesoft::Option.options("core")["core"]["smtp"]
      delivery_options = {address: @smtp["address"],
                          port: @smtp["port"],
                          domain: @smtp["domain"],
                          user_name: @smtp["user_name"],
                          password: @smtp["password"],
                          authentication: @smtp["authentication"]}
      devise_mail(record, :reset_password_instructions, {delivery_method_options: delivery_options})
    end
    
    def confirmation_instructions(record, token, opts={})
      @token = token
      @smtp = Naturesoft::Option.options("core")["core"]["smtp"]
      delivery_options = {address: @smtp["address"],
                          port: @smtp["port"],
                          domain: @smtp["domain"],
                          user_name: @smtp["user_name"],
                          password: @smtp["password"],
                          authentication: @smtp["authentication"]}
      devise_mail(record, :confirmation_instructions, {delivery_method_options: delivery_options})
    end
  end
end
