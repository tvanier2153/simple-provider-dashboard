class Enrollment < ApplicationRecord
  belongs_to :provider
  belongs_to :client

  validates :plan, presence: true, inclusion: { in: %w[basic premium] }

  # NTS: consider what uniqueness constraints should be applied if any.
end
