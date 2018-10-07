class Order < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name, :amount
  validates :email, format: { with: /\A[\w.]+@\w+\.\w+\z/ }
  validates :first_name, format: { with: /\A\w{2,}\z/,
                                   message: 'Only one word containing more than two letters' }
  validates :last_name, format: { with: /\A\w{2,}\z/,
                                  message: 'Only one word containing more than two letters' }
  validates :amount, numericality: { only_integer: true }

  scope :email, -> (email) { where("email like ?", "#{email}%") }
  scope :last_name, -> (last_name) { where("last_name like ?", "#{last_name}%") }

  def self.filter(filter)
    orders = Order.email(filter[:email])
    orders.last_name(filter[:last_name])
  end
end
