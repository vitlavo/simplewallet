# frozen_string_literal: true

class Wallet < ActiveRecord::Base
  belongs_to :walletable, polymorphic: true
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'
  has_many :debit_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'

  validates :balance, presence: true, numericality: { less_than: 1_000_000 }

  def owner_description
    "#{walletable.name} (#{balance})"
  end

  def credit(amount)
    lock!
    update!(balance: balance + amount)
  end

  def debit(amount)
    lock!
    update!(balance: balance - amount)
  end
end
