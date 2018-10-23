# frozen_string_literal: true

require 'test_helper'

class TransactionCreateTest < ActiveSupport::TestCase
  test 'create transaction' do
    assert_difference('Transaction.count') do
      TransactionCreate.new(amount: 10,
                            source_wallet_id: wallets(:team_wallet).id,
                            target_wallet_id: wallets(:user_wallet).id).call
    end
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
