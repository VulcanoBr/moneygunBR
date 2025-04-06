class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  belongs_to :owner, class_name: "User"

  include Transfer

  has_many :projects, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  has_one_attached :logo

  pay_customer default_payment_processor: :stripe, stripe_attributes: :stripe_attributes

  delegate :email, to: :owner

  def stripe_attributes(pay_customer)
    {
      metadata: {
        pay_customer_id: pay_customer.id,
        organization_id: id
      }
    }
  end

  def pay_should_sync_customer?
    super || saved_change_to_owner_id?
  end
end
