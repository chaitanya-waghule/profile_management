# Manages CRUD operations for Session of user
class SessionsController < ApplicationController

  before_action :redirect_if_user_logged_in, only: %i[new create]

  # Creates session for user
  #
  # @post_params :user [Hash]
  #   * :email [String] Login email for user
  #   * :password [String] Login password for authentication
  #
  # @accepts HTML
  #
  # @verb POST
  def create
    user = find_user
    if user.present? && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = t('.successfully_logged_in')
      redirect_to polymorphic_path(user)
    else
      flash[:danger] = user.present? ? t('.incorrect_password') : t('.incorrect_email')
      render :new
    end
  end

  # Destroys session of user
  #
  # @accepts HTML
  #
  # @verb DELETE
  def destroy
    session.delete(:user_id)
    flash[:success] = t('.successfully_logged_out')
    redirect_to login_path
  end

  private

  # Finds user by Email
  #
  # @return [User]
  def find_user
    login_email = params[:user][:email].downcase
    User.find_by(email: login_email) || AdminUser.find_by(email: login_email)
  end

end
