class Client < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :providers, through: :enrollments
  has_many :health_journal_entries, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # All clients for a given provider
  scope :for_provider, ->(provider_id) { joins(:enrollments).where(enrollments: { provider_id: provider_id }) }
end
