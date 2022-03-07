class AddColumnQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :author

    add_column :questions, :auther, :string
  end
end
