class User < ApplicationRecord

  default_scope { where(admin: false) }

  include Users

end
