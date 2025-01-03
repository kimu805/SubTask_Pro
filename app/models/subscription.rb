class Subscription < ApplicationRecord
  # association
  belongs_to :user

  # enum
  enum :status, [ :active, :canceled ], default: :active
end
