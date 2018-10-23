# frozen_string_literal: true

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'valid team' do
    team = Team.new(name: 'name')
    assert_equal true, team.save
  end

  test 'invalid without name' do
    team = Team.new
    refute team.valid?
    assert_not_nil team.errors[:name]
  end
end
