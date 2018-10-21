# frozen_string_literal: true

class Stock < ActiveRecord::Base
  include Walletable
  include CommonValidation
end
