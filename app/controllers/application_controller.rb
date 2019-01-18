# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_current_user
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def current_user
    if session[:current_user_id].present?
      user=User.find(session[:current_user_id])
    else
      nil
    end
  end

  def check_user_logged_in
    if current_user==nil
      return
    elsif current_user.profile_type=="Admin"
      redirect_to admins_path
    elsif current_user.profile_type=="Patient"
      if current_user.profile_created==1
          redirect_to patients_path
      else
          redirect_to new_patient_path
      end
    elsif current_user.profile_type=="Doctor"
      if current_user.profile_created==1
        redirect_to doctors_path
      else
          redirect_to new_doctor_path
      end
    end

  end

  protected

  def set_current_user
    Authorization.current_user = current_user
  end

end
