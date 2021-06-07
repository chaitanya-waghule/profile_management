module Users

  extend ActiveSupport::Concern

  included do

    self.table_name = :users

    has_secure_password

    has_one_attached :profile_picture

    validates :email,
      presence: true,
      length: { in: 6..25 },
      uniqueness: { case_sensitive: true },
      format: { with: /\A.+@.+\..+\z/ }

    validates :first_name,
      presence: true,
      length: { in: 2..15 },
      format: { with: /\A[a-zA-Z]+\z/, message: I18n.t('errors.messages.should_only_consist_of_letters') }

    validates :middle_name,
      presence: true,
      length: { in: 2..15 },
      format: { with: /\A[a-zA-Z]+\z/, message: I18n.t('errors.messages.should_only_consist_of_letters') }

    validates :last_name,
      presence: true,
      length: { in: 2..15 },
      format: { with: /\A[a-zA-Z]+\z/, message: I18n.t('errors.messages.should_only_consist_of_letters') }

    validate :validates_profile_picture_size,
      :validates_profile_picture_format,
      if: proc { profile_picture.attached? }

    before_save { self.email = email.downcase }

    has_one :address, foreign_key: :user_id, dependent: :destroy

    accepts_nested_attributes_for :address

  end

  # Full name of user
  #
  # @return [String]
  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  # Default or attached profile picture for user
  #
  # @return [ActiveStorage::Attached::One, String]
  def attached_profile_picture
    profile_picture.attached? ? profile_picture : '/assets/default_profile_picture.png'
  end

  private

  #todo Add specs for Profile picture validation

  # Validates profile picture format
  #
  # @return [void]
  def validates_profile_picture_format
    return if profile_picture.blob.content_type.match?(%r{\Aimage/.+})

    errors.add(:profile_picture, I18n.t('errors.messages.invalid_image_format'))
  end

  # Validates profile picture size
  #
  # @return [void]
  def validates_profile_picture_size
    return if (50_001..1_000_000).include?(profile_picture.blob.byte_size)

    errors.add(:profile_picture, I18n.t('errors.messages.invalid_profile_picture_size'))
  end

end
