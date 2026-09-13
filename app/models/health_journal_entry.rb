class HealthJournalEntry < ApplicationRecord
  belongs_to :client

  validates :body, presence: true

  # All journal entries for a given client, sorted by date NEEDS DATE DIRECTION CLARIFICATION
  scope :for_client, ->(client_id) { where(client_id: client_id) }

  #All journal entries across all clients of a given provider, sorted by date
  scope :for_provider, ->(provider_id) { joins(client: :enrollments).where(enrollments: { provider_id: provider_id }) }

  scope :newest_first, -> { order(created_at: :desc) }
  scope :oldest_first, -> { order(created_at: :asc) }
end
