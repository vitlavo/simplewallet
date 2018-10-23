# frozen_string_literal: true

require 'test_helper'

class StockTest < ActiveSupport::TestCase
  test 'valid stock' do
    stock = Stock.new(name: 'name')
    assert_equal true, stock.save
  end

  test 'invalid without name' do
    stock = Stock.new
    refute stock.valid?
    assert_not_nil stock.errors[:name]
  end
end
