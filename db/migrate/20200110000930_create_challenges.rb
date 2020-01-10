class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :description
      t.string :examples
      t.string :test_cases
      t.datetime :challenge_start_at
      t.datetime :challenge_end_at
      t.boolean :manually_closed

      t.timestamps
    end
  end
end
