module Naturesoft::Admin
    class AdminController < Naturesoft::ApplicationController
        before_action :authenticate_user!
        layout "naturesoft/backend"
    end
end