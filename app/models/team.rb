# frozen_string_literal: true

class Team < ActiveRecord::Base
  include Walletable
  include CommonValidation
end
