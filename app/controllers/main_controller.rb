# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @wallets      = Wallet.all
    @transaction  = Transaction.new
  end
end
