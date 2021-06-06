class Address < ApplicationRecord

  validates :address_line,
    presence: true,
    length: { in: 2..20 },
    format: { with: /\A[a-zA-Z0-9_\ ]*\z/, message: I18n.t('errors.messages.should_only_consist_of_alphanumeric_characters') }

  validates :city,
    presence: true,
    length: { in: 2..20 },
    format: { with: /\A[a-zA-Z0-9_\ ]*\z/, message: I18n.t('errors.messages.should_only_consist_of_alphanumeric_characters') }

  validates :landmark,
    presence: true,
    length: { in: 2..20 },
    format: { with: /\A[a-zA-Z0-9_\ ]*\z/, message: I18n.t('errors.messages.should_only_consist_of_alphanumeric_characters') }

  validates :mobile_number,
    presence: true,
    length: { is: 10 },
    uniqueness: true,
    numericality: { only_integer: true }

  validates :province,
    presence: true,
    length: { in: 2..20 },
    format: { with: /\A[a-zA-Z0-9_\ ]*\z/, message: I18n.t('errors.messages.should_only_consist_of_alphanumeric_characters') }

  validates :street,
    presence: true,
    length: { in: 2..20 },
    format: { with: /\A[a-zA-Z0-9_\ ]*\z/, message: I18n.t('errors.messages.should_only_consist_of_alphanumeric_characters') }

  validates :zip,
    presence: true,
    length: { in: 2..20 },
    format: { with: /\A[a-zA-Z0-9_\ ]*\z/, message: I18n.t('errors.messages.should_only_consist_of_alphanumeric_characters') }

  belongs_to :user, optional: true
  belongs_to :admin_user, foreign_key: :user_id, optional: true

end
