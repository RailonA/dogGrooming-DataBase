# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include SessionsHelper

    # before_action :authenticate_user!
    # before_action :authenticate_admin

    def authenticate_admin
      redirect_to admin_login_path, alert: 'Not authorized.' unless current_user&.has_role?(:admin)
    end

    # def set_theme
    #   prepend_view_path "app/views/sessions"
    # end
    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
