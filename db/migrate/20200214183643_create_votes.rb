# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :solution, null: false, foreign_key: true
      t.integer :votes

      t.timestamps
    end
  end
end
