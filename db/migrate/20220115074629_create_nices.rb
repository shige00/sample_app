class CreateNices < ActiveRecord::Migration[5.2]
  def change
    create_table :nices do |t|
      t.references :user
      t.references :answer

      t.timestamps
      t.index [:user_id, :answer_id], unique: true
    end
  end
end
