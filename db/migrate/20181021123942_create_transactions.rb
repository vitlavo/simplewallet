# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, index: true
      t.references :target_wallet, index: true
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.timestamps
    end

    add_foreign_key :transactions, :wallets, column: :source_wallet_id, primary_key: :id
    add_foreign_key :transactions, :wallets, column: :target_wallet_id, primary_key: :id
  end
end
