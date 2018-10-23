# frozen_string_literal: true

require 'test_helper'

class TransactionControllerTest < ActionDispatch::IntegrationTest
  test 'should create transaction' do
    assert_difference('Transaction.count') do
      post transactions_create_path, params: { transaction: { source_wallet_id: wallets(:team_wallet).id,
                                                              target_wallet_id: wallets(:user_wallet).id,
                                                              amount: 10 } }
    end

    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 'The transfer was successful', json_response['message']
  end

  test 'should not create transaction' do
    assert_no_difference('Transaction.count') do
      post transactions_create_path, params: { transaction: { source_wallet_id: nil,
                                                              target_wallet_id: nil,
                                                              amount: 10 } }
    end

    assert_response 422

    json_response = JSON.parse(response.body)
    assert_equal 'Validation failed: Source wallet must exist, Target wallet must exist', json_response['message']
  end
end
