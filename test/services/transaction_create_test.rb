# frozen_string_literal: true

require 'test_helper'

class TransactionCreateTest < ActiveSupport::TestCase
  test 'create transaction' do
    source_wallet = wallets(:team_wallet)
    target_wallet = wallets(:user_wallet)

    assert_difference('Transaction.count') do
      TransactionCreate.new(amount: 10.23,
                            source_wallet_id: source_wallet.id,
                            target_wallet_id: target_wallet.id).call
    end

    assert_equal source_wallet.reload.balance, 89.77
    assert_equal target_wallet.reload.balance, 20.23
  end

  test 'does not create transaction' do
    assert_no_difference('Transaction.count') do
      t = TransactionCreate.new(amount: 10,
                            source_wallet_id: nil,
                            target_wallet_id: nil).call
      assert_equal t.errors, 'Validation failed: Source wallet must exist, Target wallet must exist'
    end
  end
end
