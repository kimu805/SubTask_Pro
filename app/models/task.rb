class Task < ApplicationRecord
  belongs_to :user
  belongs_to :priority, optional: true
end
