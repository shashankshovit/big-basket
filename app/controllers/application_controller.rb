class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_login_valid?, except: [:index, :unavailable, :new, :create]

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) << :name
	  devise_parameter_sanitizer.for(:account_update) << :name
	end

	def ensure_login_valid?
		unless customer_signed_in? || admin_signed_in?
			flash[:alert] = "Your login isn't valid. Please login again."
			redirect_to :new_customer_session
		end
	end
end
