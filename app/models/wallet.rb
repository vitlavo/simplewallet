# frozen_string_literal: true

class Wallet < ActiveRecord::Base
  belongs_to :walletable, polymorphic: true
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'
  has_many :debit_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'

  validates :balance, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                      numericality: { less_than: 1_000_000 }
  validates :walletable, presence: true

  def owner_description
    "#{walletable.name} (#{balance})"
  end

  def credit(amount)
    update!(balance: balance + amount)
  end

  def debit(amount)
    update!(balance: balance - amount)
  end
end
