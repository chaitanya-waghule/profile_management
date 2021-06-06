# Manages CRUD actions for <tt>AdminUser</tt>
class AdminUsersController < ApplicationController

  http_basic_authenticate_with name: ENV['username'], password: ENV['password']

  before_action :redirect_if_user_logged_in, :build_admin_user, only: %i[new create]
  before_action :find_admin_user, :authenticate_user!, only: %i[edit update show]

  # Creates new <tt>AdminUser</tt>
  #
  # @post_params (see #new_admin_user_params)
  #
  # @accepts JS
  #
  # @verb POST
  def create
    @admin_user.assign_attributes(new_admin_user_params)
    if @admin_user.save
      flash[:success] = t('.successfully_created')
      redirect_to login_path
    else
      puts @admin_user.errors.full_messages
      render partial: 'users/errors', locals: { user: @admin_user }
    end
  end

  # Updates existing <tt>AdminUser</tt>
  #
  # @post_params (see #edit_admin_user_params)
  #
  # @accepts JS
  #
  # @verb PATCH
  def update
    @admin_user.assign_attributes(edit_admin_user_params)
    if @admin_user.save
      flash[:success] = t('.successfully_updated')
      redirect_to edit_admin_user_path(@admin_user)
    else
      render partial: 'users/errors', locals: { user: @admin_user }
    end
  end

  private

  # Builds Admin User and its association
  #
  # @return [void]
  def build_admin_user
    @admin_user = AdminUser.new
    @admin_user.build_address
  end

  # Finds Admin User based on +params[:id]+
  #
  # @return [void]
  def find_admin_user
    @admin_user = AdminUser.find(params[:id])
  end

  # Restricts <tt>AdminUser</tt> from accessesing details of other <tt>AdminUser</tt>
  #
  # @return [void]
  def authenticate_user!
    return if current_user == @admin_user

    flash[:danger] = t('errors.access_denied')
    redirect_to access_denied_path
  end

  # Permitted params for new Admin User(includes nested attributes)
  #
  # @post_params :admin_user [Hash]
  #   * :email [String] Email ID of the Admin User
  #   * :first_name [String] First Name of the Admin User
  #   * :middle_name [String] Middle Name of the Admin User
  #   * :last_name [String] Last Name of the Admin User
  #   * :password [String] Password entered by the Admin User
  #   * :password_confirmation [String] Password confirmation entered by the Admin User
  #   * :profile_picture [String] Profile Picture of the Admin User
  #   * :address_attributes [Hash] Address details of Admin User
  #     * :address_line [Hash] Address Line of Admin User
  #     * :city [Hash] City of Admin User
  #     * :id [Hash] Address#id
  #     * :mobile_number [Hash] Mobile number of Admin User
  #     * :landmark [Hash] Landmark of Admin User
  #     * :province [Hash] Province of Admin User
  #     * :street [Hash] Street of Admin User
  #     * :zip [Hash] Zip code of Admin User
  #
  # @return [ActionController::Parameters]
  def new_admin_user_params
    params.require(:admin_user).permit(
      :email,
      :first_name,
      :middle_name,
      :last_name,
      :password,
      :password_confirmation,
      :profile_picture,
      address_attributes: %i[address_line city id mobile_number landmark province street zip]
    )
  end

  # Permitted params for edit Admin User(includes nested attributes)
  #
  # @post_params :admin_user [Hash]
  #   * :address_attributes [Hash] Address details of Admin User
  #     * :id [Hash] Address#id
  #     * :mobile_number [Hash] Mobile number of Admin User
  #
  # @return [ActionController::Parameters]
  def edit_admin_user_params
    params.require(:admin_user).permit(address_attributes: %i[id mobile_number])
  end

end
