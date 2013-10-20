class RenamePasswordDigestToHashedPassword < ActiveRecord::Migration
  def up
    rename_column :customers, :password_digest, :hashed_password
  end

  def down
    rename_column :customers, :hashed_password, :password_digest
  end
end
