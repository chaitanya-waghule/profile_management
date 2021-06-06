class AdminUser < ApplicationRecord

  default_scope { where(admin: true) }

  include Users

end
