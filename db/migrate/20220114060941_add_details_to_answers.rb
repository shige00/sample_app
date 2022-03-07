class AddDetailsToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :user_id, :integer
    add_column :answers, :auther, :string
  end
end
