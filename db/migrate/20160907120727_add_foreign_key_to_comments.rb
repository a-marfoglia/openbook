class AddForeignKeyToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :micropost, index: true
  end
end
