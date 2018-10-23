# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(name: 'name')
    assert_equal true, user.save
  end

  test 'invalid without name' do
    user = User.new
    refute user.valid?
    assert_not_nil user.errors[:name]
  end
end
