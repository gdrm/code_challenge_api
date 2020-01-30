# frozen_string_literal: true

class CreateSolutions < ActiveRecord::Migration[6.0]
  def change
    create_table :solutions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.string :code
      t.integer :likes
      t.string :language

      t.timestamps
    end
  end
end
