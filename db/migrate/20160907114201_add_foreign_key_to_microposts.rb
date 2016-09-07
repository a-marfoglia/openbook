class AddForeignKeyToMicroposts < ActiveRecord::Migration
  def change
    add_reference :microposts, :category, index: true
  end
end
