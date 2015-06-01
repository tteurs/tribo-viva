class Purchase < ActiveRecord::Base
  attr_accessor :user_status, :registered_user_email, :unregistered_user_name, :unregistered_user_email,
                :unregistered_user_cpf
  before_validation :generate_transaction_id, on: :create

  belongs_to :user
  belongs_to :offer

  validates :user, :offer, :amount, :status, presence: true
  validates :receipt, presence: true, on: :update
  validates :amount, numericality: { only_integer: true, greater_than: 0, less_than: 4 }

  scope :pending, -> { where(status: PurchaseStatus::PENDING) }
  scope :canceled, -> { where(status: PurchaseStatus::CANCELED) }
  scope :confirmed, -> { where(status: PurchaseStatus::CONFIRMED) }

  mount_uploader :receipt, PurchaseUploader

  def confirm!
    update_attributes(status: PurchaseStatus::CONFIRMED)
  end

  def cancel!
    update_attributes(status: PurchaseStatus::CANCELED)
  end

  protected

  def generate_transaction_id
    self.transaction_id = SecureRandom.hex
  end
end