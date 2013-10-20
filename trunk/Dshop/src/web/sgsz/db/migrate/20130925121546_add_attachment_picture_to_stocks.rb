class AddAttachmentPictureToStocks < ActiveRecord::Migration
  def self.up
    change_table :stocks do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :stocks, :picture
  end
end
