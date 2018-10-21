# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  belongs_to :source_wallet, class_name: 'Wallet'
  belongs_to :target_wallet, class_name: 'Wallet'

  validates :amount, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                     numericality: { less_than: 1_000_000, greater_than: 0 }
  validates :source_wallet, presence: true
  validates :target_wallet, presence: true
  validate :different_wallets, :source_wallet_has_funds

  private

  def different_wallets
    return unless source_wallet_id && target_wallet_id

    errors.add(:source_wallet, 'should not be equal to the target wallet') if source_wallet_id == target_wallet_id
  end

  def source_wallet_has_funds
    return unless source_wallet && amount

    errors.add(:source_wallet, 'has no funds') if source_wallet.balance < amount
  end
end
