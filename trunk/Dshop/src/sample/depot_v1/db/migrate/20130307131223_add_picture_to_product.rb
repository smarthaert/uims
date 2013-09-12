class AddPictureToProduct < ActiveRecord::Migration
  def self.up
    add_attachment :products, :picture
  end

  def self.down
    remove_attachment :products, :picture
  end
end
