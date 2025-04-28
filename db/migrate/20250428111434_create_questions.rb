class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :question_text
      t.string :question_type
      t.jsonb :options

      t.timestamps
    end
  end
end
