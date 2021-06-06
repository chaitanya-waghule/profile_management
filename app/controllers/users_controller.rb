# Manages CRUD actions for <tt>User</tt>
class UsersController < ApplicationController

  before_action :redirect_if_user_logged_in, :build_user, only: %i[new create]
  before_action :find_user, :authenticate_user!, only: %i[edit update show]
  before_action :redirect_unless_admin_user_logged_in, only: :index

  # Creates new <tt>User</tt>
  #
  # @post_params (see #user_params)
  #
  # @accepts JS
  #
  # @verb POST
  def create
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = t('.successfully_created')
      redirect_to login_path
    else
      render partial: 'users/errors', locals: { user: @user }
    end
  end

  # Updates existing <tt>User</tt>
  #
  # @post_params (see #user_params)
  #
  # @accepts JS
  #
  # @verb PATCH
  def update
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = t('.successfully_updated')
      redirect_to edit_user_path(@user)
    else
      render partial: 'users/errors', locals: { user: @user }
    end
  end

  # Renders list of Non-Admin Users
  #
  # @accepts HTMl
  #
  # @verb GET
  def index
    @users = User.all
  end

  private

  # Builds Non-Admin User and its association
  #
  # @return [void]
  def build_user
    @user = User.new
    @user.build_address
  end

  # Finds Non-Admin User based on +params[:id]+
  #
  # @return [void]
  def find_user
    @user = User.find(params[:id])
  end

  # Restricts <tt>User</tt> from accessesing details of other <tt>User</tt>
  #
  # @return [void]
  def authenticate_user!
    return if current_user_admin? || current_user == @user

    flash[:danger] = t('errors.access_denied')
    redirect_to access_denied_path
  end

  # Permitted params for new Non-Admin User(includes nested attributes)
  #
  # @post_params :user [Hash]
  #   * :email [String] Email ID of the User
  #   * :first_name [String] First Name of the User
  #   * :middle_name [String] Middle Name of the User
  #   * :last_name [String] Last Name of the User
  #   * :password [String] Password entered by the User
  #   * :password_confirmation [String] Password confirmation entered by the User
  #   * :profile_picture [String] Profile Picture of the User
  #   * :address_attributes [Hash] Address details of User
  #     * :address_line [Hash] Address Line of User
  #     * :city [Hash] City of User
  #     * :id [Hash] Address#id
  #     * :mobile_number [Hash] Mobile number of User
  #     * :landmark [Hash] Landmark of User
  #     * :province [Hash] Province of User
  #     * :street [Hash] Street of User
  #     * :zip [Hash] Zip code of User
  #
  # @return [ActionController::Parameters]
  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :middle_name,
      :last_name,
      :password,
      :password_confirmation,
      :profile_picture,
      address_attributes: %i[address_line city id landmark mobile_number province street zip]
    )
  end

  # Redirects unless <tt>AdminUser</tt> logged in
  #
  # @return [void]
  def redirect_unless_admin_user_logged_in
    return if current_user_admin?

    flash[:danger] = t('errors.access_denied')
    redirect_to access_denied_path
  end

end
