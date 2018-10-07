class Order < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name, :amount
  validates :email, format: { with: /\A[\w.]+@\w+\.\w+\z/ }
  validates :first_name, format: { with: /\A\w{2,}\z/,
                                   message: 'Only one word containing more than two letters' }
  validates :last_name, format: { with: /\A\w{2,}\z/,
                                  message: 'Only one word containing more than two letters' }
  validates :amount, numericality: { only_integer: true }
end
