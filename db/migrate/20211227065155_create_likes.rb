class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :movie

      t.timestamps
      t.index [:user_id, :movie_id], unique: true
    end
  end
end
