# Accepts Request and sends Response after performing the required operations
class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_user, :user_logged_in?, :current_user_admin?

  private

  # Current logged in user
  #
  # @return [AdminUser, User]
  def current_user
    return @current_user if @current_user.present?

    session_user_id = session[:user_id]
    @current_user = if session_user_id.present?
      User.find_by(id: session_user_id) || AdminUser.find_by(id: session_user_id)
    end
  end

  # Verifies if user is logged in
  def user_logged_in?
    current_user.present?
  end

  # Verifies if <tt>AdminUser</tt> is logged in
  def current_user_admin?
    current_user&.admin?
  end

  # Redirect if user is logged in
  #
  # @return [AdminUser, User]
  def redirect_if_user_logged_in
    return unless user_logged_in?

    flash[:danger] = t('errors.access_denied')
    redirect_to edit_polymorphic_path(current_user)
  end

  # Renders not found page
  #
  # @return [void]
  def record_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  # Access denied URL
  #
  # @return [String]
  def access_denied_path
    user_logged_in? ? polymorphic_path(current_user) : login_path
  end

end
