class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :date
    add_column :users, :occupation, :string
  end
end
