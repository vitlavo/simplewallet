# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @wallets      = Wallet.order(:id).all
    @transaction  = Transaction.new
  end
end
