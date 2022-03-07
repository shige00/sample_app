class AddDetailsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_id, :integer
    add_column :questions, :author, :string
  end
end
