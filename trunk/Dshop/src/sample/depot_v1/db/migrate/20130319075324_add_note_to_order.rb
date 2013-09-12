class AddNoteToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :note, :text
  end
end
