# frozen_string_literal: true

require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test 'get index' do
    get main_index_path
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:wallets)
    assert_not_nil assigns(:transaction)
  end
end
