# frozen_string_literal: true

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test 'valid transaction' do
    transaction = Transaction.new(amount: 10, source_wallet: wallets(:team_wallet),
                                  target_wallet: wallets(:user_wallet))
    assert_equal true, transaction.save
  end

  test 'invalid: amount not numeric' do
    transaction = Transaction.new(amount: 'amount', source_wallet: wallets(:team_wallet),
                                  target_wallet: wallets(:user_wallet))
    refute transaction.valid?
    assert_equal transaction.errors[:amount].first, 'is not a number'
  end

  test 'invalid: amount == 0' do
    transaction = Transaction.new(amount: 0, source_wallet: wallets(:team_wallet),
                                  target_wallet: wallets(:user_wallet))
    refute transaction.valid?
    assert_equal transaction.errors[:amount].first, 'must be greater than 0'
  end

  test 'invalid: source wallet == target wallet' do
    transaction = Transaction.new(amount: 10, source_wallet: wallets(:team_wallet),
                                  target_wallet: wallets(:team_wallet))
    refute transaction.valid?
    assert_equal transaction.errors[:source_wallet].first, 'should not be equal to the target wallet'
  end

  test 'invalid: source wallet has no funds' do
    transaction = Transaction.new(amount: 1000, source_wallet: wallets(:team_wallet),
                                  target_wallet: wallets(:user_wallet))
    refute transaction.valid?
    assert_equal transaction.errors[:source_wallet].first, 'has no funds'
  end

  test 'invalid: source wallet not exist' do
    transaction = Transaction.new(amount: 10, source_wallet: nil,
                                  target_wallet: wallets(:user_wallet))
    refute transaction.valid?
    assert_equal transaction.errors[:source_wallet].first, 'must exist'
  end

  test 'invalid: target wallet not exist' do
    transaction = Transaction.new(amount: 10, source_wallet: wallets(:user_wallet),
                                  target_wallet: nil)
    refute transaction.valid?
    assert_equal transaction.errors[:target_wallet].first, 'must exist'
  end
end
