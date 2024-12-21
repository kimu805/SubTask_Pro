class Task < ApplicationRecord
  # association
  belongs_to :user
  belongs_to :priority, optional: true

  # method
  def self.find_or_create_priority(user, priority_name)
    nil if priority_name.blank?

    user.priorities.find_or_create_by(name: priority_name.strip)
  end
end
