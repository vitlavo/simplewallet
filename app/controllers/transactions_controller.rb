# frozen_string_literal: true

class TransactionsController < ApplicationController
  def create
    service = TransactionCreate.new(transaction_params).call
    if service.errors
      render json: { status: 'error', message: service.errors }, status: :unprocessable_entity
    else
      render json: { status: 'success', message: 'The transfer was successful' }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:source_wallet_id, :target_wallet_id, :amount)
  end
end
