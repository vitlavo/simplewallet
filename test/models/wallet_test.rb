# frozen_string_literal: true

require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  self.use_transactional_tests = false

  test 'valid wallet' do
    wallet = Wallet.new(balance: 10, walletable: users(:user_1))
    assert_equal true, wallet.save
  end

  test 'invalid: owner not exist' do
    wallet = Wallet.new(balance: 10, walletable: nil)
    refute wallet.valid?
    assert_equal wallet.errors[:walletable].first, 'must exist'
  end

  test 'invalid: balance not numeric' do
    wallet = Wallet.new(balance: 'balance', walletable: users(:user_1))
    refute wallet.valid?
    assert_equal wallet.errors[:balance].first, 'is not a number'
  end

  test 'invalid: balance more than 1_000_000' do
    wallet = Wallet.new(balance: 1_000_001, walletable: users(:user_1))
    refute wallet.valid?
    assert_equal wallet.errors[:balance].first, 'must be less than 1000000'
  end

  test 'credit locking works correctly' do
    wallet = wallets(:team_wallet) # balance 100

    processes = Array.new(2) do
      ForkBreak::Process.new do
        wallet.credit(10)
      end
    end

    processes.each { |process| process.finish.wait }

    assert_equal wallet.reload.balance, 120
  end

  test 'debit locking works correctly' do
    wallet = wallets(:team_wallet) # balance 100

    processes = Array.new(2) do
      ForkBreak::Process.new do
        wallet.debit(10)
      end
    end

    processes.each { |process| process.finish.wait }

    assert_equal wallet.reload.balance, 80
  end
end
