# frozen_string_literal: true

module Walletable
  extend ActiveSupport::Concern

  included do
    has_one :wallet, as: :walletable
  end
end
