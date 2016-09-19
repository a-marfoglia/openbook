class AddViewsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :views_count, :int, default: 0
  end
end
