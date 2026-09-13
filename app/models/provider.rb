class Provider < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :clients, through: :enrollments

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # All providers for a given client
  scope :for_client, ->(client_id) { joins(:enrollments).where(enrollments: { client_id: client_id }) }
end
