# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :solution, null: false, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
