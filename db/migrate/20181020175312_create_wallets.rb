# frozen_string_literal: true

class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true, index: true
      t.decimal :balance, precision: 8, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end
