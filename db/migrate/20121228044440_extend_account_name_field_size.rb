class ExtendAccountNameFieldSize < ActiveRecord::Migration
  def up
    change_column(:accounts, :name, :string, :limit => 100, :null => false, :default => "")
  end

  def down
    change_column(:accounts, :name, :string, :limit => 64, :null => false, :default => "")
  end
end
