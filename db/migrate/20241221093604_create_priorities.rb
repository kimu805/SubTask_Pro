class CreatePriorities < ActiveRecord::Migration[8.0]
  def change
    create_table :priorities do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end