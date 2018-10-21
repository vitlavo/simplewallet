# frozen_string_literal: true

class TransactionCreate
  attr_reader :errors, :transaction

  def initialize(params)
    @params = params
    @errors = @transaction = nil
  end

  def call
    ActiveRecord::Base.transaction do
      @transaction = Transaction.create!(@params)
      @transaction.source_wallet.debit(@transaction.amount)
      @transaction.target_wallet.credit(@transaction.amount)
      self
    end
  rescue ActiveRecord::RecordInvalid => exception
    @errors = exception.message
    self
  end
end
